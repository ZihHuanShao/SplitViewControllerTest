//
//  TemporaryGroupViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class TemporaryGroupViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var functionName: UILabel!
    
    // MARK: - Properties
    
    var tableViewDelegate: TemporaryGroupViewControllerTableViewDelegate?
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

extension TemporaryGroupViewController {
    private func updateDataSource() {
        tableViewDelegate = TemporaryGroupViewControllerTableViewDelegate(temporaryGroupViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: TEMPORARY_GROUP_TABLE_VIEW_CELL, cellId: TEMPORARY_GROUP_TABLE_VIEW_CELL)
    }
    
    private func updateUI() {
        functionName.text = str_map_temporaryGroup
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

extension TemporaryGroupViewController {
    func setDelegate(mapViewController: MapViewController) {
        delegate = mapViewController
    }
}

// MARK: - Protocol

protocol TemporaryGroupViewControllerDelegate {
    func temporaryGroupDidTapBack()
}
