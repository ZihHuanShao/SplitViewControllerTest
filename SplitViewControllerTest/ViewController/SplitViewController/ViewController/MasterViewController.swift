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
        
    // TitleView Filed
    @IBOutlet weak var dispatcherButton: UIButton!
    @IBOutlet weak var dispatcherName: UILabel!
    
    // ContainerView Field
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    var dispPttViewController: DispPttViewController?
    
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

extension MasterViewController {
    
    private func removeObserver() {
        if let _ = gVar.Notification.switchMainMenuObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.switchMainMenuObserver!)
            gVar.Notification.switchMainMenuObserver = nil
            print("removeObserver: switchMainMenuObserver")
        }
    }
    
    private func addObserver() {
        if gVar.Notification.switchMainMenuObserver == nil {
            gVar.Notification.switchMainMenuObserver = NotificationCenter.default.addObserver(forName: SWITCH_MAIN_MENU_NOTIFY_KEY, object: nil, queue: nil, using: switchMainMenu)
            print("addObserver: switchMainMenuObserver")
        }
    }
    
    private func updateUI() {
        // TitleView Field
        dispatcherButton.layer.cornerRadius = dispatcherButton.frame.size.width / 2
        dispatcherButton.clipsToBounds      = true
        dispatcherName.text = "調度員MAXKIT"
    }
    
    // DispPttViewController
    private func locatePttViewController(_ selectedMainMenuRowIndex: Int) {
        let dispPttViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAIN, bundle: nil).instantiateViewController(withIdentifier: "DispPttViewController") as! DispPttViewController
        
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        dispPttViewController.setMainMenuSelectedRowIndex(selectedMainMenuRowIndex)
        
        self.addChild(dispPttViewController)
        dispPttViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(dispPttViewController.view)
        
        dispPttViewController.didMove(toParent: self)
    }
    
    // DispMapViewController
    private func locateMapViewController(_ selectedMainMenuRowIndex: Int) {
        let dispMapViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAIN, bundle: nil).instantiateViewController(withIdentifier: "DispMapViewController") as! DispMapViewController
        
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        dispMapViewController.setMainMenuSelectedRowIndex(selectedMainMenuRowIndex)
        
        self.addChild(dispMapViewController)
        dispMapViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(dispMapViewController.view)
        
        dispMapViewController.didMove(toParent: self)
    }
    
}

// MARK: - Notification Methods

extension MasterViewController {

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

extension MasterViewController {
}
