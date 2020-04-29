//
//  dp_AddMemberViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
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

class dp_AddMemberViewControllerTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_AddMemberViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewExtendDelegate: AddMemberViewControllerTableViewDelegateExtend?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var membersVo = [dp_MemberVo]()
    
    // MARK: - initializer
    
    init(dp_addMemberViewController: dp_AddMemberViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_addMemberViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        tableViewExtendDelegate = self.viewController
    }
}

// MARK: - Private Methods

extension dp_AddMemberViewControllerTableViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        for dp_memberVo in membersVo {
            cellsData.append(CellData(dp_memberVo))
        }

    }
}

// MARK: - Public Methods

extension dp_AddMemberViewControllerTableViewDelegate {
    func updateMembersVo(_ membersVo: [dp_MemberVo]) {
        self.membersVo = membersVo
    }
    
    func deselectMember(rowIndex: Int) {
        membersVo[rowIndex].isSelected = false
    }
    
    func resetMembers() {
        for dp_memberVo in membersVo {
            dp_memberVo.isSelected = false
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

extension dp_AddMemberViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membersVo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DP_ADD_MEMBER_TABLE_VIEW_CELL, for: indexPath) as! dp_AddMemberTableViewCell
        
        let cellData = cellsData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.setMemberName(name: cellData.dp_memberVo?.name ?? "")
        cell.setMemberImage(name: cellData.dp_memberVo?.imageName ?? "")

        
        (cellData.dp_memberVo?.isSelected == true) ? cell.enableCheckbox() : cell.disableCheckbox()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension dp_AddMemberViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex  = indexPath.row
        
        if let cellData = cellsData[rowIndex].dp_memberVo {
            cellData.isSelected = !(cellData.isSelected)
        }

        //
        let dp_selectedMemberVo = membersVo[rowIndex]
        print("rowIndex: \(rowIndex), memberName: \(String(describing: dp_selectedMemberVo.name))")
        tableViewExtendDelegate?.pickupMember(tableRowIndex: rowIndex, dp_selectedMemberVo: dp_selectedMemberVo)
        
        reloadUI()
    }
}

// MARK: - Protocol

protocol AddMemberViewControllerTableViewDelegateExtend {
    
    // 選到的Member會被加入到CollectionView裡面
    func pickupMember(tableRowIndex: Int, dp_selectedMemberVo: dp_MemberVo)
    
}
