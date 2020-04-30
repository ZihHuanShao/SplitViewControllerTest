//
//  DispRealTimePositioningViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispRealTimePositioningViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var functionName: UILabel!
    
    // MARK: - Properties
    
    var tableViewDelegate: DispRealTimePositioningViewControllerTableViewDelegate?
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

extension DispRealTimePositioningViewController {
    private func updateDataSource() {
        tableViewDelegate = DispRealTimePositioningViewControllerTableViewDelegate(dispRealTimePositioningViewController: self, tableView: tableView)
    }
    
    private func updateUI() {
        functionName.text = str_dispMap_realTimePositioning
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

extension DispRealTimePositioningViewController {
    func setDelegate(dispMapViewController: DispMapViewController) {
        delegate = dispMapViewController
    }
}

// MARK: - Protocol

protocol RealTimePositioningViewControllerDelegate {
    func realTimePositioningDidTapBack() // 點擊「返回」
}
