//
//  AddMemberViewControllerTableViewDelegate.swift
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

class AddMemberViewControllerTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: AddMemberViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewExtendDelegate: AddMemberViewControllerTableViewDelegateExtend?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var membersVo = [MemberVo]()
    
    // MARK: - initializer
    
    init(addMemberViewController: AddMemberViewController, tableView: UITableView) {
        super.init()
        self.viewController = addMemberViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
        tableViewExtendDelegate = self.viewController
    }
}

// MARK: - Private Methods

extension AddMemberViewControllerTableViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        for memberVo in membersVo {
            cellsData.append(CellData(memberVo))
        }

    }
}

// MARK: - Public Methods

extension AddMemberViewControllerTableViewDelegate {
    func updateMembersVo(_ membersVo: [MemberVo]) {
        self.membersVo = membersVo
    }
    
    func deselectMember(rowIndex: Int) {
        membersVo[rowIndex].isSelected = false
    }
    
    func resetMembers() {
        for memberVo in membersVo {
            memberVo.isSelected = false
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

extension AddMemberViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membersVo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ADD_MEMBER_TABLE_VIEW_CELL, for: indexPath) as! AddMemberTableViewCell
        
        let cellData = cellsData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.setMemberName(name: cellData.memberVo?.name ?? "")
        cell.setMemberImage(name: cellData.memberVo?.imageName ?? "")

        
        (cellData.memberVo?.isSelected == true) ? cell.enableCheckbox() : cell.disableCheckbox()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension AddMemberViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex  = indexPath.row
        
        if let cellData = cellsData[rowIndex].memberVo {
            cellData.isSelected = !(cellData.isSelected)
        }

        //
        let selectedMemberVo = membersVo[rowIndex]
        print("rowIndex: \(rowIndex), memberName: \(String(describing: selectedMemberVo.name))")
        tableViewExtendDelegate?.pickupMember(tableRowIndex: rowIndex, selectedMemberVo: selectedMemberVo)
        
        reloadUI()
    }
}

// MARK: - Protocol

protocol AddMemberViewControllerTableViewDelegateExtend {
    
    // 選到的Member會被加入到CollectionView裡面
    func pickupMember(tableRowIndex: Int, selectedMemberVo: MemberVo)
    
}
