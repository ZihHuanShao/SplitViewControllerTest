//
//  GroupDispatchViewTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var groupVo: GroupVo?
    
    init(_ groupVo: GroupVo) {
        self.groupVo = groupVo
    }
}

class GroupDispatchViewTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: GroupDispatchViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewExtendDelegate: GroupDispatchTableViewExtendDelegate?
    
    fileprivate var cellsData = [CellData]()
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

// MARK: - Private Methods

extension GroupDispatchViewTableViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        for groupVo in groupsVo {
            cellsData.append(CellData(groupVo))
        }

    }
}

// MARK: - Public Methods

extension GroupDispatchViewTableViewDelegate {
    func updateGroupsVo(_ groupsVo: [GroupVo]) {
        self.groupsVo = groupsVo
    }
    
    func deselectGroup(rowIndex: Int) {
        groupsVo[rowIndex].isSelected = false
    }
    
    func resetGroups() {
        for groupVo in groupsVo {
            groupVo.isSelected = false
        }

        cellsData.removeAll()
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

extension GroupDispatchViewTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsVo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_DISPATCH_TABLE_VIEW_CELL, for: indexPath) as! GroupDispatchTableViewCell
        
        let cellData = cellsData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.setGroupName(name: cellData.groupVo?.name ?? "")
        cell.setGroupImage(name: cellData.groupVo?.imageName ?? "")
        cell.setGroupMemberCount(cellData.groupVo?.count ?? 0)
        cell.setGroupDesc(desc: cellData.groupVo?.desc ?? "")
        
        (cellData.groupVo?.isSelected == true) ? cell.enableCheckbox() : cell.disableCheckbox()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension GroupDispatchViewTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex  = indexPath.row
        
        if let cellData = cellsData[rowIndex].groupVo {
            cellData.isSelected = !(cellData.isSelected)
        }

        //
        let selectedGroupVo = groupsVo[rowIndex]
        print("rowIndex: \(rowIndex), groupName: \(String(describing: selectedGroupVo.name))")
        tableViewExtendDelegate?.pickupGroup(tableRowIndex: rowIndex, selectedGroupVo: selectedGroupVo)
        
        reloadUI()
    }
}

// MARK: - Protocol

protocol GroupDispatchTableViewExtendDelegate {
    
    // 選到的Group會被加入到CollectionView裡面
    func pickupGroup(tableRowIndex: Int, selectedGroupVo: GroupVo)
    
}
