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
    
    var preMainMenuCell: MainMenuCollectionViewCell?
    var mainMenuCells = [MainMenuCollectionViewCell]()
    
    
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
        
        switch indexPath.row {
        case 0:
            cell.setMainMenuIcon(name: "phone-white-icon")
        case 1:
            cell.setMainMenuIcon(name: "maps-icon")
        case 2:
            cell.setMainMenuIcon(name: "Camera-2-icon")
        case 3:
            cell.setMainMenuIcon(name: "Time-Machine-icon")
        default:
            break
        }
        
        mainMenuCells.append(cell)
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _preMainMenuCell = preMainMenuCell {
            _preMainMenuCell.disableColor()
        }
        
        mainMenuCells[indexPath.row].enableColor()
        
        preMainMenuCell = mainMenuCells[indexPath.row]
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 64)
    }
}
