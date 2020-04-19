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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitViewController?.preferredDisplayMode = .allVisible
        
        addObserver()
        
        let pttViewController = UIStoryboard(name: STORYBOARD_NAME_MAIN, bundle: nil).instantiateViewController(withIdentifier: "PttViewController") as! PttViewController
        
        self.addChild(pttViewController)
        pttViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(pttViewController.view)
        
        pttViewController.didMove(toParent: self)
    }
}

// MARK: - Private Methods

extension MasterViewController {
    
    private func removeObserver() {
//        if let _ = gVar.changeMonitorObserver {
//            NotificationCenter.default.removeObserver(gVar.changeMonitorObserver!)
//            gVar.changeMonitorObserver = nil
//            print("removeObserver: changeMonitorObserver")
//        }

    }
    
    private func addObserver() {
//        if gVar.changeMonitorObserver == nil {
//            gVar.changeMonitorObserver = NotificationCenter.default.addObserver(forName: CHANGE_MONITOR_NOTIFY_KEY, object: nil, queue: nil, using: changeMonitor)
//            print("addObserver: changeMonitorObserver")
//        }
        

        
    }
    
}

// MARK: - Notification Methods

extension MasterViewController {

//    func reloadGroupTableView(notification: Notification) -> Void {
//        tableViewDelegate?.reloadUI()
//    }
}


// MARK: - Event Methods

extension MasterViewController {
}
