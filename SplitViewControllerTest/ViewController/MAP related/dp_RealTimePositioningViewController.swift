//
//  dp_RealTimePositioningViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_RealTimePositioningViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var functionName: UILabel!
    
    // MARK: - Properties
    
    var tableViewDelegate: dp_RealTimePositioningViewControllerTableViewDelegate?
    var delegate: RealTimePositioningViewControllerDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDataSource()
        updateUI()
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonTouchDown(_ sender: UIButton) {
        updateBackButtonImage(type: .PRESSED)
    }
    @IBAction func backButtonTouchDragExit(_ sender: UIButton) {
        updateBackButtonImage(type: .AWAY)
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        updateBackButtonImage(type: .AWAY)
        delegate?.realTimePositioningDidTapBack()
    }
}

// MARK: - Private Methods

extension dp_RealTimePositioningViewController {
    private func updateDataSource() {
        tableViewDelegate = dp_RealTimePositioningViewControllerTableViewDelegate(dp_realTimePositioningViewController: self, tableView: tableView)
    }
    
    private func updateUI() {
        functionName.text = str_map_realTimePositioning
        tableViewDelegate?.reloadUI()
    }
    
    private func updateBackButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            backButtonImage.image = UIImage(named: "btn_contact_pressed")
            
        case .AWAY:
            backButtonImage.image = UIImage(named: "btn_contact_normal")
        }
    }
}


// MARK: - Public Methods

extension dp_RealTimePositioningViewController {
    func setDelegate(dp_mapViewController: dp_MapViewController) {
        delegate = dp_mapViewController
    }
}

// MARK: - Protocol

protocol RealTimePositioningViewControllerDelegate {
    func realTimePositioningDidTapBack()
}
