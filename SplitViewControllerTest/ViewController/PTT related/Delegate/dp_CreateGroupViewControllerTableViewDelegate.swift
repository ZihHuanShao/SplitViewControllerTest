//
//  dp_CreateGroupViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var memberVo: MemberVo?
    
    init(_ memberVo: MemberVo) {
        self.memberVo = memberVo
    }
}

class dp_CreateGroupViewControllerTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_CreateGroupViewController?
    fileprivate weak var tableView: UITableView?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var membersVo = [MemberVo]()
    
    // MARK: - initializer
    
    init(dp_createGroupViewController: dp_CreateGroupViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_createGroupViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
    }
}

// MARK: - Private Methods

extension dp_CreateGroupViewControllerTableViewDelegate {
    private func reloadCellData() {
        for memberVo in membersVo {
            cellsData.append(CellData(memberVo))
        }
    }
}

// MARK: - Public Methods

extension dp_CreateGroupViewControllerTableViewDelegate {
    func updateMembersVo(_ membersVo: [MemberVo]) {
        self.membersVo = membersVo
    }
    
    func registerCell(cellName: String, cellId: String) {
        tableView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellId
        )
    }
    
    func reloadUI() {
        reloadCellData()
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension dp_CreateGroupViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  membersVo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DP_CREATE_GROUP_TABLE_VIEW_CELL, for: indexPath) as! dp_CreateGroupTableViewCell
        
        let cellData = cellsData[indexPath.row]
        
        cell.setMemberName(name: cellData.memberVo?.name ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension dp_CreateGroupViewControllerTableViewDelegate: UITableViewDelegate {
    
}

