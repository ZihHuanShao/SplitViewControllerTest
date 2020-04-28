//
//  dp_DispatchBoardSplitViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class dp_DispatchBoardSplitViewController: UISplitViewController {

    // MARK: - Properties

    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
    }
    
    override func viewDidLayoutSubviews() {
        
        //let iPadHeight = UIScreen.main.bounds.height
        //let kMasterViewWidth: CGFloat = iPadHeight * 0.4
        //print("iPadHeight: \(iPadHeight), kMasterViewWidth: \(kMasterViewWidth)")
        
        let kMasterViewWidth: CGFloat = 240.0
        
        let dp_masterViewController = self.viewControllers[0]
        let dp_detailViewController = self.viewControllers[1]
        
        if dp_detailViewController.view.frame.origin.x > 0.0 {
            
            // Adjust the width of the master view
            var masterViewFrame = dp_masterViewController.view.frame
            let deltaX = masterViewFrame.size.width - kMasterViewWidth
            masterViewFrame.size.width -= deltaX
            dp_masterViewController.view.frame = masterViewFrame
            
            // Adjust the width of the detail view
            var detailViewFrame = dp_detailViewController.view.frame
            detailViewFrame.origin.x -= deltaX
            detailViewFrame.size.width += deltaX
            dp_detailViewController.view.frame = detailViewFrame
            
            // [橫擺情況下] 將畫面的height及通訊錄跟主畫面的width存起來(根據不同iPad尺寸有所不同)
            // iPad Master width
            UserDefaults.standard.set(dp_masterViewController.view.frame.size.width, forKey: SPLIT_MASTER_VIEW_CONTROLLER_WIDTH)
            // iPad Detail width
            UserDefaults.standard.set(dp_detailViewController.view.frame.size.width, forKey: SPLIT_DETAIL_VIEW_CONTROLLER_WIDTH)
            // iPad height
            UserDefaults.standard.set(dp_masterViewController.view.frame.size.height, forKey: SPLIT_VIEW_CONTROLLER_HEIGHT)
            
            dp_masterViewController.view.setNeedsLayout()
            dp_detailViewController.view.setNeedsLayout()
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension dp_DispatchBoardSplitViewController {

    private func removeObserver() {
        if let _ = gVar.keepOriginalSplitViewControllerObserver {
            NotificationCenter.default.removeObserver(gVar.keepOriginalSplitViewControllerObserver!)
            gVar.keepOriginalSplitViewControllerObserver = nil
            print("removeObserver: keepOriginalSplitViewControllerObserver")
        }
    }
    
    private func addObserver() {
        if gVar.keepOriginalSplitViewControllerObserver == nil {
            gVar.keepOriginalSplitViewControllerObserver = NotificationCenter.default.addObserver(forName: KEEP_ORIGINAL_SPLIT_VIEW_CONTROLLER_NOTIFY_KEY, object: nil, queue: nil, using: keepOriginalSplitViewController)
               
                   print("addObserver: keepOriginalSplitViewControllerObserver")
        }
    }
}

// MARK: - Notification Methods

extension dp_DispatchBoardSplitViewController {
    
    func keepOriginalSplitViewController(notification: Notification) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.setOriginalSplitViewController(self)
    }
}
