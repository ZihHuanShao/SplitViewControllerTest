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
    var originalSplitVC: DispatchBoardSplitViewController?

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
        
        NotificationCenter.default.post(name: KEEP_ORIGINAL_SPLIT_VIEW_CONTROLLER_NOTIFY_KEY, object: nil, userInfo: nil)
        
        // create a new view controller with it
        let underlayVC = UIViewController.init()
        
        // grab a screenshot and set to backgroundImage
        let backgroundImage = UIImageView.init(image: grabScreenshot())
        underlayVC.view = backgroundImage
        
        // swap the split view
        window?.rootViewController = underlayVC
         
        // present the overlay
        if let vc = presentVC {
            underlayVC.present(vc, animated: true, completion: nil)
        }
        // 避免presentVC為nil時的處理
        else {
            self.window?.rootViewController = self.originalSplitVC
        }
    }
}

extension AppDelegate {
    func showGroupDispatchModal(groupsVo: [GroupVo]) {
        
        let storyboard = UIStoryboard(name: STORYBOARD_NAME_GROUP, bundle: nil)
        let groupDispatchViewController = storyboard.instantiateViewController(withIdentifier: GROUP_DISPATCH_VIEW_CONTROLLER) as? GroupDispatchViewController
        
        groupDispatchViewController?.updateGroupsVo(groupsVo)

        groupDispatchViewController?.modalPresentationStyle = .formSheet
        
        showPresentView(viewController: groupDispatchViewController)
    }
    
    func showAddMemberModal(membersVo: [MemberVo]) {
         
         let storyboard = UIStoryboard(name: STORYBOARD_NAME_GROUP, bundle: nil)
         let addMemberViewController = storyboard.instantiateViewController(withIdentifier: ADD_MEMBER_VIEW_CONTROLLER) as? AddMemberViewController
         
         addMemberViewController?.updateMembersVo(membersVo)

         addMemberViewController?.modalPresentationStyle = .formSheet
         
         showPresentView(viewController: addMemberViewController)
    }
    
    func dismissOverlayWithSelectedMembers(_ membersVo: [MemberVo]?) {
        // dismiss the overlay
        window?.rootViewController?.dismiss(animated: true, completion: {
            if let vc = self.originalSplitVC {
                self.window?.rootViewController = vc
            }
            gVar.isHoldFormSheetView = false
            
            // reload建立群組中的群組成員tableview
            if let _membersVo = membersVo {
                NotificationCenter.default.post(name: SELECTED_MEMBERS_RELOADED_NOTIFY_KEY, object: self, userInfo: [SELECTED_MEMBERS_RELOADED_USER_KEY: _membersVo])
            }
        })
    }
    
    func dismissOverlay() {
        // dismiss the overlay
        window?.rootViewController?.dismiss(animated: true, completion: {
            if let vc = self.originalSplitVC {
                self.window?.rootViewController = vc
            }
            gVar.isHoldFormSheetView = false
            
            // reload群組列表的tableview
            NotificationCenter.default.post(name: RELOAD_GROUP_TABLE_VIEW_NOTIFY_KEY, object: self, userInfo: nil)
        })
        
    }
    
    func setOriginalSplitViewController(_ viewController: DispatchBoardSplitViewController) {
        self.originalSplitVC = viewController
    }
}
