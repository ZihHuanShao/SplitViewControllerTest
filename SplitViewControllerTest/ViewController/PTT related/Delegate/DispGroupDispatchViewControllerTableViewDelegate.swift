//
//  DispGroupDispatchViewControllerTableViewDelegate.swift
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

class DispGroupDispatchViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: DispGroupDispatchViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewExtendDelegate: GroupDispatchViewControllerTableViewDelegateExtend?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var groupsVo = [GroupVo]()
    
    // MARK: - initializer
    
    init(dispGroupDispatchViewController: DispGroupDispatchViewController, tableView: UITableView) {
        super.init()
        self.viewController = dispGroupDispatchViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        tableViewExtendDelegate = self.viewController
    }
    
}

// MARK: - Private Methods

extension DispGroupDispatchViewControllerTableViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        for groupVo in groupsVo {
            cellsData.append(CellData(groupVo))
        }

    }
}

// MARK: - Public Methods

extension DispGroupDispatchViewControllerTableViewDelegate {
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

extension DispGroupDispatchViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsVo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DISP_GROUP_DISPATCH_TABLE_VIEW_CELL, for: indexPath) as! DispGroupDispatchTableViewCell
        
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

extension DispGroupDispatchViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex  = indexPath.row
        
        if let cellData = cellsData[rowIndex].groupVo, let isSelected = cellData.isSelected {
            cellData.isSelected = !isSelected
        }

        //
        let selectedGroupVo = groupsVo[rowIndex]
        print("rowIndex: \(rowIndex), groupName: \(String(describing: selectedGroupVo.name))")
        tableViewExtendDelegate?.pickupGroup(tableRowIndex: rowIndex, selectedGroupVo: selectedGroupVo)
        
        reloadUI()
    }
}

// MARK: - Protocol

protocol GroupDispatchViewControllerTableViewDelegateExtend {
    
    // 選到的Group會被加入到CollectionView裡面
    func pickupGroup(tableRowIndex: Int, selectedGroupVo: GroupVo)
    
}
