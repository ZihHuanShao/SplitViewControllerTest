//
//  GroupDispatchTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class GroupDispatchTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: GroupDispatchViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewExtendDelegate: GroupDispatchTableViewExtendDelegate?
    fileprivate var groupCells = [GroupDispatchTableViewCell]()

    fileprivate var groupsVo = [GroupVo]()
    
    // MARK: - initializer
    
    init(groupDispatchViewController: GroupDispatchViewController, tableView: UITableView) {
        super.init()
        self.viewController = groupDispatchViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        tableViewExtendDelegate = self.viewController
    }
    
}

// MARK: - Public Methods

extension GroupDispatchTableViewDelegate {
        func updateGroupsVo(_ groupsVo: [GroupVo]) {
        self.groupsVo = groupsVo
    }
    
    func deselectGroup(rowIndex: Int) {
        groupCells[rowIndex].disableCheckbox()
    }
    
    func resetGroups() {
        for cell in groupCells {
            cell.disableCheckbox()
        }

        groupCells.removeAll()
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

extension GroupDispatchTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsVo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_DISPATCH_TABLE_VIEW_CELL, for: indexPath) as! GroupDispatchTableViewCell
        
        cell.selectionStyle = .none
        cell.setGroupName(name: groupsVo[indexPath.row].name ?? "")
        cell.setGroupImage(name: groupsVo[indexPath.row].imageName ?? "")
        cell.setGroupMemberCount(groupsVo[indexPath.row].count ?? 0)
        cell.setGroupDesc(desc: groupsVo[indexPath.row].desc ?? "")
        
        groupCells.append(cell)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension GroupDispatchTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex  = indexPath.row
        
        // display checked
        groupCells[rowIndex].triggerCheckbox()
        
        //
        let selectedGroupVo = groupsVo[rowIndex]
        print("rowIndex: \(rowIndex), groupName: \(String(describing: selectedGroupVo.name))")
        tableViewExtendDelegate?.pickupGroup(tableRowIndex: rowIndex, selectedGroupVo: selectedGroupVo)
    }
}

// MARK: - Protocol

protocol GroupDispatchTableViewExtendDelegate {
    
    // 選到的Group會被加入到CollectionView裡面
    func pickupGroup(tableRowIndex: Int, selectedGroupVo: GroupVo)
    
}
