//
//  dp_AddMemberViewControllerCollectionViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var tableRowIndex: Int?
    var dp_memberVo: dp_MemberVo?
    
    init(tableRowIndex: Int, _ dp_memberVo: dp_MemberVo) {
        self.tableRowIndex = tableRowIndex
        self.dp_memberVo = dp_memberVo
    }
}


class dp_AddMemberViewControllerCollectionViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_AddMemberViewController?
    fileprivate weak var collectionView: UICollectionView?
    
    // 目前所挑選要加入新群組的成員
    fileprivate var selectedMembers = [dp_SelectedMemberVo]()
    
    fileprivate var cellsData = [CellData]()
    
    // MARK: - initializer
    
    init(dp_addMemberViewController: dp_AddMemberViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = dp_addMemberViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
    
}

// MARK: - Private Methods

extension dp_AddMemberViewControllerCollectionViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        
        for member in selectedMembers {
            if let dp_memberVo = member.dp_memberVo , let tableRowIndex = member.tableRowIndex {
                cellsData.append(CellData(tableRowIndex: tableRowIndex, dp_memberVo))
            }
        }
    }
}

// MARK: - Public Methods

extension dp_AddMemberViewControllerCollectionViewDelegate {
    
    func appendSelectedMember(tableRowIndex: Int, _ dp_selectedMemberVo: dp_MemberVo) {
        
        var isPickedup = false
        var collectionRowIndex = Int()
        
        for (index, selectedMember) in selectedMembers.enumerated() {
            if selectedMember.tableRowIndex == tableRowIndex {
                // 已經被挑選了
                isPickedup = true
                collectionRowIndex = index
            }
        }
        
        if isPickedup {
            // 移除已挑選的成員
            dp_selectedMemberVo.isSelected = false
            selectedMembers.remove(at: collectionRowIndex)
        } else {
            // 加入已挑選的成員
            dp_selectedMemberVo.isSelected = true
            selectedMembers.append(dp_SelectedMemberVo(tableRowIndex: tableRowIndex, dp_memberVo: dp_selectedMemberVo))
        }
        
    }
    
    func removeSelectedMember(tableRowIndex: Int) {
        var collectionRowIndex = Int()
        
        for (index, member) in selectedMembers.enumerated() {
            if member.tableRowIndex == tableRowIndex {
                collectionRowIndex = index
            }
        }
        
        selectedMembers.remove(at: collectionRowIndex)
        
    }
    
    func resetSelectMembers() {
        selectedMembers.removeAll()
    }
    
    func getSelectedMembers() -> [dp_MemberVo] {
        var selectedMembersVo = [dp_MemberVo]()
        
        for selectedMember in selectedMembers {
            if let dp_memberVo = selectedMember.dp_memberVo {
                selectedMembersVo.append(dp_memberVo)
            }
        }
        
        return selectedMembersVo
    }
    
    func registerCell(cellName: String, cellId: String) {
        collectionView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellWithReuseIdentifier: cellId
        )
    }
    
    func reloadUI() {
        reloadCellData()
        collectionView?.reloadData()
    }
}


// MARK: - UICollectionViewDataSource

extension dp_AddMemberViewControllerCollectionViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DP_ADD_MEMBER_COLLECTION_VIEW_CELL, for: indexPath) as! dp_AddMemberCollectionViewCell

        let cellData = cellsData[indexPath.row]
        
        if let tableRowIndex = cellData.tableRowIndex {
            cell.setTableRowIndex(tableRowIndex)
        }
        
        cell.setMemberName(name: cellData.dp_memberVo?.name ?? "")
        cell.setMemberImage(name: cellData.dp_memberVo?.imageName ?? "")
        
        return cell
    }
    
    
}


// MARK: - UICollectionViewDelegate

extension dp_AddMemberViewControllerCollectionViewDelegate: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension dp_AddMemberViewControllerCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 72)
    }
}
