//
//  MasterViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    var pttViewController: PttViewController?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitViewController?.preferredDisplayMode = .allVisible
        
        locatePttViewController()
        addObserver()
        

    }
}

// MARK: - Private Methods

extension MasterViewController {
    
    private func removeObserver() {
        if let _ = gVar.switchMainMenuObserver {
            NotificationCenter.default.removeObserver(gVar.switchMainMenuObserver!)
            gVar.switchMainMenuObserver = nil
            print("removeObserver: switchMainMenuObserver")
        }
    }
    
    private func addObserver() {
        if gVar.switchMainMenuObserver == nil {
            gVar.switchMainMenuObserver = NotificationCenter.default.addObserver(forName: SWITCH_MAIN_MENU_NOTIFY_KEY, object: nil, queue: nil, using: switchMainMenu)
            print("addObserver: switchMainMenuObserver")
        }
    }
    
    private func locatePttViewController() {
        let pttViewController = UIStoryboard(name: STORYBOARD_NAME_MAIN, bundle: nil).instantiateViewController(withIdentifier: "PttViewController") as! PttViewController
        
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        self.addChild(pttViewController)
        pttViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(pttViewController.view)
        
        pttViewController.didMove(toParent: self)
    }
    
    private func locateMapViewController() {
        let mapViewController = UIStoryboard(name: STORYBOARD_NAME_MAIN, bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        self.addChild(mapViewController)
        mapViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(mapViewController.view)
        
        mapViewController.didMove(toParent: self)
    }
    
}

// MARK: - Notification Methods

extension MasterViewController {

    func switchMainMenu(notification: Notification) -> Void {
        if let flag = notification.userInfo?[SWITCH_MAIN_MENU_USER_KEY] as? Bool {
            if flag == true {
                locateMapViewController()
            } else {
                locatePttViewController()
            }
        }
    }
}


// MARK: - Event Methods

extension MasterViewController {
}
