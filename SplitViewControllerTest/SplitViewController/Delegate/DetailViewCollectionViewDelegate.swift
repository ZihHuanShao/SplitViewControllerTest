//
//  DetailViewCollectionViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var mainMenuIconVo: MainMenuIconVo?
    
    init(_ mainMenuIconVo: MainMenuIconVo) {
        self.mainMenuIconVo = mainMenuIconVo
    }
}

class DetailViewCollectionViewDelegate: NSObject {

    // MARK: - Properties
    
    fileprivate weak var viewController: DetailViewController?
    fileprivate weak var collectionView: UICollectionView?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var mainMenuIconsVo  = [MainMenuIconVo]()
    
    fileprivate var preSelectedIconIndex: Int?
    
    // MARK: - initializer
    
    init(detailViewController: DetailViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = detailViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
}

// MARK: - Public Methods

extension DetailViewCollectionViewDelegate {
    func updateMainMenuIcons(mainMenuIconsVo: [MainMenuIconVo]) {
        self.mainMenuIconsVo = mainMenuIconsVo
    }
    
    func reloadUI() {
        reloadCellData()
        collectionView?.reloadData()
    }
}

// MARK: - Private Methods

extension DetailViewCollectionViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        for mainMenuIconVo in mainMenuIconsVo {
            cellsData.append(CellData(mainMenuIconVo))
        }
    }
    
    private func setBackgroundColor(rowIndex: Int) {
        if let index = preSelectedIconIndex {
            mainMenuIconsVo[index].isSelected = false
        }
        
        mainMenuIconsVo[rowIndex].isSelected = true
    }
}

// MARK: - UICollectionViewDataSource

extension DetailViewCollectionViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAINMENU_COLLECTION_VIEW_CELL, for: indexPath) as! MainMenuCollectionViewCell
        
        let cellData = cellsData[indexPath.row]
        
        if (cellData.mainMenuIconVo?.isSelected == true) {
            cell.setMainMenuIcon(name: cellData.mainMenuIconVo?.selectedIconName ?? "")
        } else {
            cell.setMainMenuIcon(name: cellData.mainMenuIconVo?.unselectedIconName ?? "")
        }
    
       
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        setBackgroundColor(rowIndex: indexPath.row)
        
        preSelectedIconIndex = indexPath.row
        
        if indexPath.row == 1 {
            NotificationCenter.default.post(name: SWITCH_MAIN_MENU_NOTIFY_KEY, object: self, userInfo: [SWITCH_MAIN_MENU_USER_KEY: true])
        } else if indexPath.row == 2 {
            NotificationCenter.default.post(name: SWITCH_MAIN_MENU_NOTIFY_KEY, object: self, userInfo: [SWITCH_MAIN_MENU_USER_KEY: false])
        }
        
        reloadUI()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 固定80*64
        return CGSize(width: 80, height: 64)
    }
}
