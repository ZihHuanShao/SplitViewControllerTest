//
//  DispGroupViewControllerCollectionoViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/30.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var memberVo: MemberVo?
    
    init(_ memberVo: MemberVo) {
        self.memberVo = memberVo
    }
}

class DispGroupViewControllerCollectionoViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: DispGroupViewController?
    fileprivate weak var collectionView: UICollectionView?
    fileprivate var membersCount: Int?
    fileprivate var membersVo = [MemberVo]()
    fileprivate var cellsData = [CellData]()
    fileprivate var delegateExtend: GroupViewControllerCollectionoViewDelegateExtend?
    
    // MARK: - initializer
    
    init(dispGroupViewController: DispGroupViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = dispGroupViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        delegateExtend = self.viewController
    }
    
}

// MARK: - Private Methods

extension DispGroupViewControllerCollectionoViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        
        for memberVo in membersVo {
            cellsData.append(CellData(memberVo))
        }
    }
}

// MARK: - Public Methods

extension DispGroupViewControllerCollectionoViewDelegate {
    func updateMembersVo(_ membersVo: [MemberVo]) {
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

extension DispGroupViewControllerCollectionoViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return membersCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DISP_GROUP_COLLECTION_VIEW_CELL, for: indexPath) as! DispGroupCollectionViewCell
        
        guard let memberVo = cellsData[indexPath.row].memberVo else {
            return cell
        }
        
        cell.setMemberName(name: memberVo.name ?? "")
        cell.setMemberImage(name: memberVo.imageName ?? "")
        
        switch memberVo.onlineState {
        case .AVAILABLE:    cell.setOnlineState(type: .AVAILABLE)
        case .BUSY:         cell.setOnlineState(type: .BUSY)
        case .NO_DISTURB:   cell.setOnlineState(type: .NO_DISTURB)
        case .OFFLINE:      cell.setOnlineState(type: .OFFLINE)
        }

        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension DispGroupViewControllerCollectionoViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(membersVo[indexPath.row].name)
        
        let cellData = cellsData[indexPath.row]
        delegateExtend?.didTapGroupMember(memberVo: cellData.memberVo)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DispGroupViewControllerCollectionoViewDelegate: UICollectionViewDelegateFlowLayout {
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
    func didTapGroupMember(memberVo: MemberVo?)
}