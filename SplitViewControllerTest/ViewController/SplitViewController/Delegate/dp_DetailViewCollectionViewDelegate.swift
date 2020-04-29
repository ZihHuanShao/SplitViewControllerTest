//
//  dp_DetailViewCollectionViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var dp_mainMenuIconVo: dp_MainMenuIconVo?
    
    init(_ dp_mainMenuIconVo: dp_MainMenuIconVo) {
        self.dp_mainMenuIconVo = dp_mainMenuIconVo
    }
}

class dp_DetailViewCollectionViewDelegate: NSObject {

    // MARK: - Properties
    
    fileprivate weak var viewController: dp_DetailViewController?
    fileprivate weak var collectionView: UICollectionView?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var mainMenuIconsVo  = [dp_MainMenuIconVo]()
    
    fileprivate var preSelectedIconIndex: Int?
    
    
    // MARK: - initializer
    
    init(dp_detailViewController: dp_DetailViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = dp_detailViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
}

// MARK: - Public Methods

extension dp_DetailViewCollectionViewDelegate {
    func updateMainMenuIcons(mainMenuIconsVo: [dp_MainMenuIconVo]) {
        self.mainMenuIconsVo = mainMenuIconsVo
    }
    
    func reloadUI() {
        reloadCellData()
        collectionView?.reloadData()
    }
    
    func setBackgroundColor(_ rowIndex: Int) {
        if let index = preSelectedIconIndex {
            mainMenuIconsVo[index].isSelected = false
        }
        
        mainMenuIconsVo[rowIndex].isSelected = true
    }
}

// MARK: - Private Methods

extension dp_DetailViewCollectionViewDelegate {
    private func reloadCellData() {
        cellsData.removeAll()
        for dp_mainMenuIconVo in mainMenuIconsVo {
            cellsData.append(CellData(dp_mainMenuIconVo))
        }
    }
    
    
}

// MARK: - UICollectionViewDataSource

extension dp_DetailViewCollectionViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DP_MAINMENU_COLLECTION_VIEW_CELL, for: indexPath) as! dp_MainMenuCollectionViewCell
        
        let cellData = cellsData[indexPath.row]
        
        if (cellData.dp_mainMenuIconVo?.isSelected == true) {
            cell.setMainMenuIcon(name: cellData.dp_mainMenuIconVo?.selectedIconName ?? "")
        } else {
            cell.setMainMenuIcon(name: cellData.dp_mainMenuIconVo?.unselectedIconName ?? "")
        }
    
       
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension dp_DetailViewCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
//        setBackgroundColor(rowIndex: indexPath.row)
        
//        preSelectedIconIndex = indexPath.row
        
        if indexPath.row == 0 {
            let userInfo = SwitchMainMenuUserInfo(mainMenuType: .PTT, selectedRowIndex: 0)
            NotificationCenter.default.post(
                name: SWITCH_MAIN_MENU_NOTIFY_KEY,
                object: self,
                userInfo: [SWITCH_MAIN_MENU_USER_KEY: userInfo]
            )
        } else if indexPath.row == 1 {
            let userInfo = SwitchMainMenuUserInfo(mainMenuType: .MAP, selectedRowIndex: 1)
            NotificationCenter.default.post(
                name: SWITCH_MAIN_MENU_NOTIFY_KEY,
                object: self,
                userInfo: [SWITCH_MAIN_MENU_USER_KEY: userInfo]
            )
        } else if indexPath.row == 2 {
            let userInfo = SwitchMainMenuUserInfo(mainMenuType: .PTT, selectedRowIndex: 2)
            NotificationCenter.default.post(
                name: SWITCH_MAIN_MENU_NOTIFY_KEY,
                object: self,
                userInfo: [SWITCH_MAIN_MENU_USER_KEY: userInfo]
            )
        }
        
//        preSelectedIconIndex = indexPath.row
        reloadUI()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension dp_DetailViewCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 固定80*64
        return CGSize(width: 80, height: 64)
    }
}
