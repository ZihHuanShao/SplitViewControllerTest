//
//  dp_MasterViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class dp_MasterViewController: UIViewController {

    // MARK: - IBOutlet
        
    // TitleView Filed
    @IBOutlet weak var dispatcherButton: UIButton!
    @IBOutlet weak var dispatcherName: UILabel!
    
    // ContainerView Field
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    var dp_pttViewController: dp_PttViewController?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitViewController?.preferredDisplayMode = .allVisible
        
        updateUI()
        
        // 預設顯示PTTViewController
        locatePttViewController(0)
        addObserver()
        

    }
    
    // MARK: - Actions
    
    @IBAction func dispatcherSetting(_ sender: UIButton) {
        print("dispatcherSetting pressed")
    }
}

// MARK: - Private Methods

extension dp_MasterViewController {
    
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
    
    private func updateUI() {
        // TitleView Field
        dispatcherButton.layer.cornerRadius = dispatcherButton.frame.size.width / 2
        dispatcherButton.clipsToBounds      = true
        dispatcherName.text = "調度員MAXKIT"
    }
    
    // dp_PttViewController
    private func locatePttViewController(_ selectedMainMenuRowIndex: Int) {
        let dp_pttViewController = UIStoryboard(name: STORYBOARD_NAME_DP_MAIN, bundle: nil).instantiateViewController(withIdentifier: "dp_PttViewController") as! dp_PttViewController
        
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        dp_pttViewController.setMainMenuSelectedRowIndex(selectedMainMenuRowIndex)
        
        self.addChild(dp_pttViewController)
        dp_pttViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(dp_pttViewController.view)
        
        dp_pttViewController.didMove(toParent: self)
    }
    
    // dp_MapViewController
    private func locateMapViewController(_ selectedMainMenuRowIndex: Int) {
        let dp_mapViewController = UIStoryboard(name: STORYBOARD_NAME_DP_MAIN, bundle: nil).instantiateViewController(withIdentifier: "dp_MapViewController") as! dp_MapViewController
        
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        dp_mapViewController.setMainMenuSelectedRowIndex(selectedMainMenuRowIndex)
        
        self.addChild(dp_mapViewController)
        dp_mapViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(dp_mapViewController.view)
        
        dp_mapViewController.didMove(toParent: self)
    }
    
}

// MARK: - Notification Methods

extension dp_MasterViewController {

    func switchMainMenu(notification: Notification) -> Void {
        if let userInfo = notification.userInfo?[SWITCH_MAIN_MENU_USER_KEY] as? SwitchMainMenuUserInfo {
            if let mainMenuSelectedRowIndex = userInfo.selectedRowIndex {
                switch userInfo.mainMenuType {
                    
                case .PTT:
                    locatePttViewController(mainMenuSelectedRowIndex)
                    
                case .MAP:
                    locateMapViewController(mainMenuSelectedRowIndex)
                    
                case .VIDEO:
                    break
                    
                case .RECORD:
                    break
                    
                case .NONE:
                    break
                }
            }
            

        }
    }
}


// MARK: - Event Methods

extension dp_MasterViewController {
}
