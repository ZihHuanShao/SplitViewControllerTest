//
//  DetailViewCollectionViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

class DetailViewCollectionViewDelegate: NSObject {

    // MARK: - Properties
    
    weak var viewController: DetailViewController?
    weak var collectionView: UICollectionView?
    
    var preMainMenuCellIndex: Int?
    var preMainMenuCell: MainMenuCollectionViewCell?
    var mainMenuCells = [MainMenuCollectionViewCell]()
    
    let mainMenuIcons_unselected = ["btn_menu_ptt_normal",
                                    "btn_menu_map_normal",
                                    "btn_menu_video_normal",
                                    "btn_menu_history_normal"
                                   ]
    let mainMenuIcons_selected   = ["btn_menu_ptt_selected",
                                    "btn_menu_map_selected",
                                    "btn_menu_video_selected",
                                    "btn_menu_history_selected"
                                   ]
    
    // MARK: - initializer
    
    init(detailViewController: DetailViewController, collectionView: UICollectionView) {
        super.init()
        self.viewController = detailViewController
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate   = self
//        collectionView.alwaysBounceVertical = false
//        collectionView.alwaysBounceHorizontal = true
        
        
    }
}

// MARK: - Public Methods

extension DetailViewCollectionViewDelegate {
    func reloadUI() {
        collectionView?.reloadData()
    }
}

// MARK: - Private Methods

extension DetailViewCollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource

extension DetailViewCollectionViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAINMENU_COLLECTION_VIEW_CELL, for: indexPath) as! MainMenuCollectionViewCell
        
        cell.setMainMenuIcon(name: mainMenuIcons_unselected[indexPath.row])
        
        mainMenuCells.append(cell)
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _preCell = preMainMenuCell, let _preCellIndex = preMainMenuCellIndex {
            _preCell.setMainMenuIcon(name: mainMenuIcons_unselected[_preCellIndex])
        }
        
        let iconName = mainMenuIcons_selected[indexPath.row]
        mainMenuCells[indexPath.row].setMainMenuIcon(name: iconName)
        
        preMainMenuCell = mainMenuCells[indexPath.row]
        preMainMenuCellIndex = indexPath.row
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 固定80*64
        return CGSize(width: 80, height: 64)
    }
}
