//
//  GroupViewCollectionoViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/30.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

class GroupViewCollectionoViewDelegate: NSObject {
    
    // MARK: - Properties
    
    weak var viewController: GroupViewController?
    weak var collectionView: UICollectionView?
    var number = Int()
    
    // MARK: - initializer
    
    init(groupViewController: GroupViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = groupViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
    
}

extension GroupViewCollectionoViewDelegate {
    func setGroupNumber(_ num: Int) {
        number = num
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

extension GroupViewCollectionoViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return number
//        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GROUP_COLLECTION_VIEW_CELL, for: indexPath)
        return cell
    }
    
    
}

extension GroupViewCollectionoViewDelegate: UICollectionViewDelegate {
    
}

extension GroupViewCollectionoViewDelegate: UICollectionViewDelegateFlowLayout {
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
