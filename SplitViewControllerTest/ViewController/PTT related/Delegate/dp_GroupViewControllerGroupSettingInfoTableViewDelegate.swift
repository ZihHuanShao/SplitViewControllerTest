//
//  dp_GroupViewControllerGroupSettingInfoTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/23.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class dp_GroupViewControllerGroupSettingInfoTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_GroupViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var monitorState = Bool()

    // MARK: - initializer
    
    init(dp_groupViewController: dp_GroupViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_groupViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension dp_GroupViewControllerGroupSettingInfoTableViewDelegate {
    
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

extension dp_GroupViewControllerGroupSettingInfoTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupSettingType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DP_GROUP_SETTING_INFO_TABLE_VIEW_CELL, for: indexPath) as! dp_GroupSettingInfoTableViewCell
        
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

extension dp_GroupViewControllerGroupSettingInfoTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(GroupSettingType.allCases[indexPath.row])
    }
}
