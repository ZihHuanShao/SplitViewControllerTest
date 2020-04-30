//
//  DispTemporaryGroupViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispTemporaryGroupViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var functionName: UILabel!
    
    // MARK: - Properties
    
    var tableViewDelegate: DispTemporaryGroupViewControllerTableViewDelegate?
    var delegate: TemporaryGroupViewControllerDelegate?
    
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
        delegate?.temporaryGroupDidTapBack()
    }

}

// MARK: - Private Methods

extension DispTemporaryGroupViewController {
    private func updateDataSource() {
        tableViewDelegate = DispTemporaryGroupViewControllerTableViewDelegate(dispTemporaryGroupViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_TEMPORARY_GROUP_TABLE_VIEW_CELL, cellId: DISP_TEMPORARY_GROUP_TABLE_VIEW_CELL)
    }
    
    private func updateUI() {
        functionName.text = str_dispMap_temporaryGroup
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

extension DispTemporaryGroupViewController {
    func setDelegate(dispMapViewController: DispMapViewController) {
        delegate = dispMapViewController
    }
}

// MARK: - Protocol

protocol TemporaryGroupViewControllerDelegate {
    func temporaryGroupDidTapBack() // 點擊「返回」
}
