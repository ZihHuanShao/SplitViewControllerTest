//
//  DispGroupViewControllerGroupSettingInfoTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/23.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class DispGroupViewControllerGroupSettingInfoTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: DispGroupViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var monitorState = Bool()

    // MARK: - initializer
    
    init(dispGroupViewController: DispGroupViewController, tableView: UITableView) {
        super.init()
        self.viewController = dispGroupViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension DispGroupViewControllerGroupSettingInfoTableViewDelegate {
    
    func enableMonitorButton() {
        monitorState = true
    }
    
    func disableMonitorButton() {
        monitorState = false
    }
    
    func registerCell(cellName: String, cellId: String) {
        tableView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellId
        )
    }
    
    func reloadUI() {
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension DispGroupViewControllerGroupSettingInfoTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupSettingType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DISP_GROUP_SETTING_INFO_TABLE_VIEW_CELL, for: indexPath) as! DispGroupSettingInfoTableViewCell
        
        cell.updateCell(GroupSettingType.allCases[indexPath.row])
        
        if GroupSettingType.allCases[indexPath.row] == .MONITOR_MODE {
            (monitorState == true) ? cell.enableSwitchButton() : cell.disableSwitchButton()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - UITableViewDelegate

extension DispGroupViewControllerGroupSettingInfoTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(GroupSettingType.allCases[indexPath.row])
    }
}
