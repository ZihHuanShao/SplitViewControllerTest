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
    
    func appendSelectedGroup(rowIndex: Int, name: String) {
        
        var isPickedup = false
        var selectedGroupsIndex = Int()
        
        for (index, group) in selectedGroups.enumerated() {
            if group.rowIndex == rowIndex {
                // 已經被挑選了
                isPickedup = true
                selectedGroupsIndex = index
            }
        }
        
        if isPickedup {
            selectedGroups.remove(at: selectedGroupsIndex)
        } else {
            selectedGroups.append(SelectedGroupInfo(rowIndex: rowIndex, name: name))
        }
        
    }
    
    func removeSelectedGroup(rowIndex: Int) {
        var selectedGroupsIndex = Int()
        
        for (index, group) in selectedGroups.enumerated() {
            if group.rowIndex == rowIndex {
                selectedGroupsIndex = index
            }
        }
        
        selectedGroups.remove(at: selectedGroupsIndex)
        
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

        cell.setGroupName(name: selectedGroups[indexPath.row].name)
        if let rowIndex = selectedGroups[indexPath.row].rowIndex {
            cell.setRowIndex(rowIndex)
        }
        
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
