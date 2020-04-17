//
//  AppDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var splitView: DispatchBoardSplitViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    private func grabScreenshot() -> UIImage? {
        
        // create graphics context with screen size
        let screenRect = UIScreen.main.bounds
        UIGraphicsBeginImageContext(screenRect.size)
        
        let context = UIGraphicsGetCurrentContext()
        UIColor.black.set()
        context?.fill(screenRect)
        
        // grab reference to our window
        let window = UIApplication.shared.keyWindow
        
        // transfer content into our context
        window?.layer.render(in: context!)
        
        let screengrab = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return screengrab
        
    }
    
    private func showPresentView(viewController: UIViewController?) {
        
        var presentVC: UIViewController?
        
        if let vc = viewController as? AddMemberViewController {
            presentVC = vc
        } else if let vc = viewController as? GroupDispatchViewController {
            presentVC = vc
        }
        
        // create a new view controller with it
        let underlayVC = UIViewController.init()
        
        // grab a screenshot
        let backgroundImage = UIImageView.init(image: grabScreenshot())
        
        underlayVC.view = backgroundImage
        
        // swap the split view
        splitView = window?.rootViewController as? DispatchBoardSplitViewController
        window?.rootViewController = underlayVC
         
        // present the overlay
        if let _presentVC = presentVC {
            underlayVC.present(_presentVC, animated: true, completion: nil)
        } else {
            self.window?.rootViewController = self.splitView
        }
    }
}

extension AppDelegate {
    func showGroupDispatch(groupsVo: [GroupVo]) {
        
        let storyboard = UIStoryboard(name: STORYBOARD_NAME_GROUP, bundle: nil)
        let groupDispatchViewController = storyboard.instantiateViewController(withIdentifier: GROUP_DISPATCH_VIEW_CONTROLLER) as? GroupDispatchViewController
        
        groupDispatchViewController?.updateGroupsVo(groupsVo)

        groupDispatchViewController?.modalPresentationStyle = .formSheet
        
        showPresentView(viewController: groupDispatchViewController)
    }
    
    func showAddMember(membersVo: [MemberVo]) {
         
         let storyboard = UIStoryboard(name: STORYBOARD_NAME_GROUP, bundle: nil)
         let addMemberViewController = storyboard.instantiateViewController(withIdentifier: ADD_MEMBER_VIEW_CONTROLLER) as? AddMemberViewController
         
         addMemberViewController?.updateMembersVo(membersVo)

         addMemberViewController?.modalPresentationStyle = .formSheet
         
         showPresentView(viewController: addMemberViewController)
    }
    
    func dismissOverlay(_ withMembersVo: [MemberVo]?) {
        // dismiss the overlay
        window?.rootViewController?.dismiss(animated: true, completion: {
            
            self.window?.rootViewController = self.splitView
            gVar.isHoldFormSheetView = false
            
            if let membersVo = withMembersVo {
                NotificationCenter.default.post(name: SELECTED_MEMBERS_RELOADED_NOTIFY_KEY, object: self, userInfo: [SELECTED_MEMBERS_RELOADED_USER_KEY: membersVo])
            }
            
        })
    }
    
    func dismissOverlay() {
        
        // dismiss the overlay
        window?.rootViewController?.dismiss(animated: true, completion: {
            self.window?.rootViewController = self.splitView
            gVar.isHoldFormSheetView = false
        })
    }
}
