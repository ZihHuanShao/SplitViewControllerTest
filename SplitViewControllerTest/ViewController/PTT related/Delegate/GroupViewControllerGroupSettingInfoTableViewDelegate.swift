//
//  GroupViewControllerGroupSettingInfoTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/23.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class GroupViewControllerGroupSettingInfoTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: GroupViewController?
    fileprivate weak var tableView: UITableView?
    

    // MARK: - initializer
    
    init(groupViewController: GroupViewController, tableView: UITableView) {
        super.init()
        self.viewController = groupViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension GroupViewControllerGroupSettingInfoTableViewDelegate {
    
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

extension GroupViewControllerGroupSettingInfoTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupSettingType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_SETTING_INFO_TABLE_VIEW_CELL, for: indexPath) as! GroupSettingInfoTableViewCell
        
        cell.updateCell(GroupSettingType.allCases[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - UITableViewDelegate

extension GroupViewControllerGroupSettingInfoTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(GroupSettingType.allCases[indexPath.row])
    }
}
