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
    fileprivate var groups = [String]()
    fileprivate var groupsDesc = [String]()
    fileprivate var groupsCount = [Int]()
    
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
    func setGroups(data: [String]) {
        groups = data
    }
    
    func setgroupsDesc(descs: [String]) {
        groupsDesc = descs
    }
    
    func setgroupsCount(numbers: [Int]) {
        groupsCount = numbers
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
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_DISPATCH_TABLE_VIEW_CELL, for: indexPath) as! GroupDispatchTableViewCell
        
        cell.selectionStyle = .none
        cell.setGroupName(name: groups[indexPath.row])
        cell.setGroupMemberCount(groupsCount[indexPath.row])
        cell.setGroupDesc(desc: groupsDesc[indexPath.row])
        
        
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
        
        // display checked
        groupCells[indexPath.row].triggerCheckbox()
        
        //
        let rowIndex  = indexPath.row
        let groupName = groups[rowIndex]
        print("rowIndex: \(rowIndex), groupName: \(groupName)")
        tableViewExtendDelegate?.pickupGroup(rowIndex: rowIndex, name: groupName)
    }
}

// MARK: - Protocol

protocol GroupDispatchTableViewExtendDelegate {
    
    // 選到的Group會被加入到CollectionView裡面
    func pickupGroup(rowIndex: Int, name: String)
    
}
