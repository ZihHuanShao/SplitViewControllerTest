//
//  DispMainMenuCollectionViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class DispMainMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mainMenuItem: UIImageView!
    
}

// MARK: - Public Methods

extension DispMainMenuCollectionViewCell {

    func setMainMenuIcon(name: String) {
        if let image = UIImage(named: name) {
            mainMenuItem.image = image
        }
    }
    
    func enableBackgroundColor(name: String) {
        if let image = UIImage(named: name) {
            mainMenuItem.image = image
        }
    }
    
    func disableBackgroundColor(name: String) {
        if let image = UIImage(named: name) {
            mainMenuItem.image = image
        }
    }
    
}

// MARK: - Private Methods

extension DispMainMenuCollectionViewCell {
    private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat(rgbValue  & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
