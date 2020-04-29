//
//  dp_GroupViewControllerCollectionoViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/30.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var dp_memberVo: dp_MemberVo?
    
    init(_ dp_memberVo: dp_MemberVo) {
        self.dp_memberVo = dp_memberVo
    }
}

class dp_GroupViewControllerCollectionoViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_GroupViewController?
    fileprivate weak var collectionView: UICollectionView?
    fileprivate var membersCount: Int?
    fileprivate var membersVo = [dp_MemberVo]()
    fileprivate var cellsData = [CellData]()
    fileprivate var delegateExtend: GroupViewControllerCollectionoViewDelegateExtend?
    
    // MARK: - initializer
    
    init(dp_groupViewController: dp_GroupViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = dp_groupViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        delegateExtend = self.viewController
    }
    
}

// MARK: - Private Methods

extension dp_GroupViewControllerCollectionoViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        
        for dp_memberVo in membersVo {
            cellsData.append(CellData(dp_memberVo))
        }
    }
}

// MARK: - Public Methods

extension dp_GroupViewControllerCollectionoViewDelegate {
    func updateMembersVo(_ membersVo: [dp_MemberVo]) {
        self.membersVo = membersVo
    }
    
    func setGroupMembersCount(_ count: Int) {
        membersCount = count
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

extension dp_GroupViewControllerCollectionoViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return membersCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DP_GROUP_COLLECTION_VIEW_CELL, for: indexPath) as! dp_GroupCollectionViewCell
        
        guard let dp_memberVo = cellsData[indexPath.row].dp_memberVo else {
            return cell
        }
        
        cell.setMemberName(name: dp_memberVo.name ?? "")
        cell.setMemberImage(name: dp_memberVo.imageName ?? "")
        
        switch dp_memberVo.onlineState {
        case .AVAILABLE:    cell.setOnlineState(type: .AVAILABLE)
        case .BUSY:         cell.setOnlineState(type: .BUSY)
        case .NO_DISTURB:   cell.setOnlineState(type: .NO_DISTURB)
        case .OFFLINE:      cell.setOnlineState(type: .OFFLINE)
        }

        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension dp_GroupViewControllerCollectionoViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(membersVo[indexPath.row].name)
        
        let cellData = cellsData[indexPath.row]
        delegateExtend?.didTapGroupMember(dp_memberVo: cellData.dp_memberVo)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension dp_GroupViewControllerCollectionoViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        /*------------------------
        /*根據ipad的尺寸自動分配Cell的大小 (目前不使用)*/
         
        let viewWidth = UserDefaults.standard.float(forKey: SPLIT_DETAIL_VIEW_CONTROLLER_WIDTH)
        
        // NOTE: cell間距減掉12
        // ┌─┐     ┌─┐     ┌─┐     ┌─┐
        // └─┘→ 4 ←└─┘→ 4 ←└─┘→ 4 ←└─┘
        // ┌─┐     ┌─┐     ┌─┐     ┌─┐
        // └─┘     └─┘     └─┘     └─┘

        let cellWidth = (viewWidth / 4) - 12
        
        // 固定*64
        return CGSize(width: CGFloat(cellWidth), height: 64)
         
        ------------------------*/
        
        // 固定180*70
        return CGSize(width: 180, height: 70)
    }
    
    // 每一列之間的間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    

}

protocol GroupViewControllerCollectionoViewDelegateExtend {
    func didTapGroupMember(dp_memberVo: dp_MemberVo?)
}
