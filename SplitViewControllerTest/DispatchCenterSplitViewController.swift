//
//  DispatchBoardSplitViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class DispatchBoardSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        //let iPadHeight = UIScreen.main.bounds.height
        //let kMasterViewWidth: CGFloat = iPadHeight * 0.4
        //print("iPadHeight: \(iPadHeight), kMasterViewWidth: \(kMasterViewWidth)")
        
        let kMasterViewWidth: CGFloat = 240.0
        
        let masterViewController = self.viewControllers[0]
        let detailViewController = self.viewControllers[1]
        
        if detailViewController.view.frame.origin.x > 0.0 {
            // Adjust the width of the master view
            var masterViewFrame = masterViewController.view.frame
            let deltaX = masterViewFrame.size.width - kMasterViewWidth
            masterViewFrame.size.width -= deltaX
            masterViewController.view.frame = masterViewFrame
            
            // Adjust the width of the detail view
            var detailViewFrame = detailViewController.view.frame
            detailViewFrame.origin.x -= deltaX
            detailViewFrame.size.width += deltaX
            detailViewController.view.frame = detailViewFrame
            
            masterViewController.view.setNeedsLayout()
            detailViewController.view.setNeedsLayout()
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
