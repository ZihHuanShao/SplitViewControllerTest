//
//  AddMemberViewCollectionViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var tableRowIndex: Int?
    var memberVo: MemberVo?
    
    init(tableRowIndex: Int, _ memberVo: MemberVo) {
        self.tableRowIndex = tableRowIndex
        self.memberVo = memberVo
    }
}


class AddMemberViewCollectionViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: AddMemberViewController?
    fileprivate weak var collectionView: UICollectionView?
    
    // 目前所挑選要加入新群組的成員
    fileprivate var selectedMembers = [SelectedMemberVo]()
    
    fileprivate var cellsData = [CellData]()
    
    // MARK: - initializer
    
    init(addMemberViewController: AddMemberViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = addMemberViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
    
}

// MARK: - Private Methods

extension AddMemberViewCollectionViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        
        for member in selectedMembers {
            if let memberVo = member.memberVo , let tableRowIndex = member.tableRowIndex {
                cellsData.append(CellData(tableRowIndex: tableRowIndex, memberVo))
            }
        }
    }
}

// MARK: - Public Methods

extension AddMemberViewCollectionViewDelegate {
    
    func appendSelectedMember(tableRowIndex: Int, _ selectedMemberVo: MemberVo) {
        
        var isPickedup = false
        var collectionRowIndex = Int()
        
        for (index, member) in selectedMembers.enumerated() {
            if member.tableRowIndex == tableRowIndex {
                // 已經被挑選了
                isPickedup = true
                collectionRowIndex = index
            }
        }
        
        if isPickedup {
            selectedMembers.remove(at: collectionRowIndex)
        } else {
            selectedMembers.append(SelectedMemberVo(tableRowIndex: tableRowIndex, memberVo: selectedMemberVo))
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

extension AddMemberViewCollectionViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ADD_MEMBER_COLLECTION_VIEW_CELL, for: indexPath) as! AddMemberCollectionViewCell

        let cellData = cellsData[indexPath.row]
        
        if let tableRowIndex = cellData.tableRowIndex {
            cell.setTableRowIndex(tableRowIndex)
        }
        
        cell.setMemberName(name: cellData.memberVo?.name ?? "")
        cell.setMemberImage(name: cellData.memberVo?.imageName ?? "")
        
        return cell
    }
    
    
}


// MARK: - UICollectionViewDelegate

extension AddMemberViewCollectionViewDelegate: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AddMemberViewCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 72)
    }
}
