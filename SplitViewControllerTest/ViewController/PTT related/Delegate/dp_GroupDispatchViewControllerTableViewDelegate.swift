//
//  dp_GroupDispatchViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var dp_groupVo: dp_GroupVo?
    
    init(_ dp_groupVo: dp_GroupVo) {
        self.dp_groupVo = dp_groupVo
    }
}

class dp_GroupDispatchViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_GroupDispatchViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewExtendDelegate: GroupDispatchViewControllerTableViewDelegateExtend?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var groupsVo = [dp_GroupVo]()
    
    // MARK: - initializer
    
    init(dp_groupDispatchViewController: dp_GroupDispatchViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_groupDispatchViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        tableViewExtendDelegate = self.viewController
    }
    
}

// MARK: - Private Methods

extension dp_GroupDispatchViewControllerTableViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        for dp_groupVo in groupsVo {
            cellsData.append(CellData(dp_groupVo))
        }

    }
}

// MARK: - Public Methods

extension dp_GroupDispatchViewControllerTableViewDelegate {
    func updateGroupsVo(_ groupsVo: [dp_GroupVo]) {
        self.groupsVo = groupsVo
    }
    
    func deselectGroup(rowIndex: Int) {
        groupsVo[rowIndex].isSelected = false
    }
    
    func resetGroups() {
        for dp_groupVo in groupsVo {
            dp_groupVo.isSelected = false
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

extension dp_GroupDispatchViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsVo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DP_GROUP_DISPATCH_TABLE_VIEW_CELL, for: indexPath) as! dp_GroupDispatchTableViewCell
        
        let cellData = cellsData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.setGroupName(name: cellData.dp_groupVo?.name ?? "")
        cell.setGroupImage(name: cellData.dp_groupVo?.imageName ?? "")
        cell.setGroupMemberCount(cellData.dp_groupVo?.count ?? 0)
        cell.setGroupDesc(desc: cellData.dp_groupVo?.desc ?? "")
        
        (cellData.dp_groupVo?.isSelected == true) ? cell.enableCheckbox() : cell.disableCheckbox()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension dp_GroupDispatchViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex  = indexPath.row
        
        if let cellData = cellsData[rowIndex].dp_groupVo {
            cellData.isSelected = !(cellData.isSelected)
        }

        //
        let dp_selectedGroupVo = groupsVo[rowIndex]
        print("rowIndex: \(rowIndex), groupName: \(String(describing: dp_selectedGroupVo.name))")
        tableViewExtendDelegate?.pickupGroup(tableRowIndex: rowIndex, dp_selectedGroupVo: dp_selectedGroupVo)
        
        reloadUI()
    }
}

// MARK: - Protocol

protocol GroupDispatchViewControllerTableViewDelegateExtend {
    
    // 選到的Group會被加入到CollectionView裡面
    func pickupGroup(tableRowIndex: Int, dp_selectedGroupVo: dp_GroupVo)
    
}
