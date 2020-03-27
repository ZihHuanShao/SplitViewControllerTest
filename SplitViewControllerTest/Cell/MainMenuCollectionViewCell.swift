//
//  MainMenuCollectionViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MainMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mainMenuItemBackground: UIView!
    @IBOutlet weak var mainMenuItem: UIImageView!
    
}

// MARK: - Public Methods

extension MainMenuCollectionViewCell {
    func setMainMenuIcon(name: String) {
        if let image = UIImage(named: name) {
            mainMenuItem.image = image
        }
    }
    
    func enableColor() {
        mainMenuItemBackground.backgroundColor = UIColorFromRGB(rgbValue: 0x2C2B2B)
    }
    
    func disableColor() {
        mainMenuItemBackground.backgroundColor = .clear
    }
}

// MARK: - Private Methods

extension MainMenuCollectionViewCell {
    private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat(rgbValue  & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
