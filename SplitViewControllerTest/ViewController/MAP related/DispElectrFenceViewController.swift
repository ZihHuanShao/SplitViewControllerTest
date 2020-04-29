//
//  DispElectrFenceViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/21.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispElectrFenceViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var functionName: UILabel!
    @IBOutlet weak var createElectrFenceButtonImage: UIImageView!
    @IBOutlet weak var createElectrFenceButton: UIButton!
    
    // MARK: - Properties
    
    var tableViewDelegate: DispElectrFenceViewControllerTableViewDelegate?
    var delegate: ElectrFenceViewControllerDelegate?
    
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
        delegate?.electrFenceDidTapBack()
    }

    
    //
    // createElectrFence
    //
    
    @IBAction func createElectrFenceButtonTouchDown(_ sender: UIButton) {
        updateCreateElectrFenceButtonImage(type: .PRESSED)
    }
    
    @IBAction func createElectrFenceButtonTouchDragExit(_ sender: UIButton) {
        updateCreateElectrFenceButtonImage(type: .AWAY)
    }
    
    @IBAction func createElectrFenceButtonTouchUpInside(_ sender: UIButton) {
        delegate?.electrFenceDidTapEdit()
        updateCreateElectrFenceButtonImage(type: .AWAY)
    }
}

// MARK: - Private Methods

extension DispElectrFenceViewController {
    private func updateDataSource() {
        tableViewDelegate = DispElectrFenceViewControllerTableViewDelegate(dispElectrFenceViewController: self, tableView: tableView)
    }
    
    private func updateUI() {
        createElectrFenceButton.setTitle(str_dispElectrFence_createElectrFence, for: .normal)
        functionName.text = str_dispMap_electrFence
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
    
    private func updateCreateElectrFenceButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            createElectrFenceButtonImage.image = UIImage(named: "btn_contact_pressed")
            
        case .AWAY:
            createElectrFenceButtonImage.image = UIImage(named: "btn_contact_normal")
        }
    }
}

// MARK: - Public Methods

extension DispElectrFenceViewController {
    func setDelegate(dispMapViewController: DispMapViewController) {
        delegate = dispMapViewController
    }
}

// MARK: - Protocol

protocol ElectrFenceViewControllerDelegate {
    func electrFenceDidTapBack()
    func electrFenceDidTapEdit()
}
