//
//  dp_GroupDispatchViewControllerCollectionViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/8.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var tableRowIndex: Int?
    var groupVo: GroupVo?
    
    init(tableRowIndex: Int, _ groupVo: GroupVo) {
        self.tableRowIndex = tableRowIndex
        self.groupVo = groupVo
    }
}

class dp_GroupDispatchViewControllerCollectionViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_GroupDispatchViewController?
    fileprivate weak var collectionView: UICollectionView?
    
    // 目前所挑選要調度的群組
    fileprivate var selectedGroups = [SelectedGroupVo]()
    
    fileprivate var cellsData = [CellData]()
    
    // MARK: - initializer
    
    init(dp_groupDispatchViewController: dp_GroupDispatchViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = dp_groupDispatchViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
    
}

// MARK: - Private Methods

extension dp_GroupDispatchViewControllerCollectionViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        
        for group in selectedGroups {
            if let groupVo = group.groupVo , let tableRowIndex = group.tableRowIndex {
                cellsData.append(CellData(tableRowIndex: tableRowIndex, groupVo))
            }
        }
    }
}

// MARK: - Public Methods

extension dp_GroupDispatchViewControllerCollectionViewDelegate {
    
    func appendSelectedGroup(tableRowIndex: Int, _ selectedGroupVo: GroupVo) {
        
        var isPickedup = false
        var collectionRowIndex = Int()
        
        for (index, group) in selectedGroups.enumerated() {
            if group.tableRowIndex == tableRowIndex {
                // 已經被挑選了
                isPickedup = true
                collectionRowIndex = index
            }
        }
        
        if isPickedup {
            selectedGroups.remove(at: collectionRowIndex)
        } else {
            selectedGroups.append(SelectedGroupVo(tableRowIndex: tableRowIndex, groupVo: selectedGroupVo))
        }
        
    }
    
    func removeSelectedGroup(tableRowIndex: Int) {
        var collectionRowIndex = Int()
        
        for (index, group) in selectedGroups.enumerated() {
            if group.tableRowIndex == tableRowIndex {
                collectionRowIndex = index
            }
        }
        
        selectedGroups.remove(at: collectionRowIndex)
        
    }
    
    func resetSelectGroups() {
        selectedGroups.removeAll()
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

extension dp_GroupDispatchViewControllerCollectionViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DP_GROUP_DISPATCH_COLLECTION_VIEW_CELL, for: indexPath) as! dp_GroupDispatchCollectionViewCell

        let cellData = cellsData[indexPath.row]
        
        if let tableRowIndex = cellData.tableRowIndex {
            cell.setTableRowIndex(tableRowIndex)
        }
        
        cell.setGroupName(name: cellData.groupVo?.name ?? "")
        cell.setGroupImage(name: cellData.groupVo?.imageName ?? "")
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension dp_GroupDispatchViewControllerCollectionViewDelegate: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension dp_GroupDispatchViewControllerCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 72)
    }
}
