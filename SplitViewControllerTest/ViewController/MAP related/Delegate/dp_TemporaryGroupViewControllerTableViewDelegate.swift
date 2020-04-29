//
//  dp_TemporaryGroupViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var dp_memberVo: dp_MemberVo?
    
    init(_ dp_memberVo: dp_MemberVo) {
        self.dp_memberVo = dp_memberVo
    }
}

class dp_TemporaryGroupViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
       
       fileprivate weak var viewController: dp_TemporaryGroupViewController?
       fileprivate weak var tableView: UITableView?
    
    // MARK: - initializer
    
    init(dp_temporaryGroupViewController: dp_TemporaryGroupViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_temporaryGroupViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension dp_TemporaryGroupViewControllerTableViewDelegate {
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

extension dp_TemporaryGroupViewControllerTableViewDelegate: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DP_TEMPORARY_GROUP_TABLE_VIEW_CELL, for: indexPath) as! dp_TemporaryGroupTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension dp_TemporaryGroupViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
