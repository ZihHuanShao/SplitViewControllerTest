//
//  GroupDispatchCollectionViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/8.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class GroupDispatchCollectionViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: GroupDispatchViewController?
    fileprivate weak var collectionView: UICollectionView?
    
    // 目前所挑選要調度的群組
    fileprivate var selectedGroups = [SelectedGroupInfo]()
    
    // MARK: - initializer
    
    init(groupDispatchViewController: GroupDispatchViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = groupDispatchViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
    
}

// MARK: - Public Methods

extension GroupDispatchCollectionViewDelegate {
    
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
            selectedGroups.append(
                SelectedGroupInfo(
                    tableRowIndex: tableRowIndex,
                    groupVo: selectedGroupVo
                )
            )
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
        collectionView?.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension GroupDispatchCollectionViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GROUP_DISPATCH_COLLECTION_VIEW_CELL, for: indexPath) as! GroupDispatchCollectionViewCell

        let rowIndex = indexPath.row
        
        if let tableRowIndex = selectedGroups[rowIndex].tableRowIndex {
            cell.setTableRowIndex(tableRowIndex)
        }
        
        cell.setGroupName(name: selectedGroups[rowIndex].groupVo?.name)
        cell.setGroupImage(name: selectedGroups[rowIndex].groupVo?.imageName ?? "")
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension GroupDispatchCollectionViewDelegate: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GroupDispatchCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 72)
    }
}
