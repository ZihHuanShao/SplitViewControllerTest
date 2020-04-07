//
//  GroupDispatchViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class GroupDispatchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let width1 = UserDefaults.standard.float(forKey: SPLIT_MASTER_VIEW_CONTROLLER_WIDTH)
        let width2 = UserDefaults.standard.float(forKey: SPLIT_DETAIL_VIEW_CONTROLLER_WIDTH)
        let fullHeight = UserDefaults.standard.float(forKey: SPLIT_VIEW_CONTROLLER_HEIGHT)
        let fullWidth  = width1 + width2
        
        // 讓寬度固定為整個畫面寬度的2/3, 高度固定為整個畫面高度的2/3
        preferredContentSize = CGSize(width: CGFloat(fullWidth * 0.667), height: CGFloat(fullHeight * 0.667))
        print("width = \(CGFloat(fullWidth * 0.667)), height = \(CGFloat(fullHeight * 0.667))")
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissOverlay()
    }
    

}
