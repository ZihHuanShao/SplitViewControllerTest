//
//  MemberProfileTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/31.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MemberProfileTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var profileDescLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColorFromRGB(rgbValue: 0xF4F4F4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Public Methods

extension MemberProfileTableViewCell {
    func setProfileTitle(title: String) {
        profileTitleLabel.text = title
    }
    
    func setProfileDesc(desc: String) {
        profileDescLabel.text = desc
    }
}

// MARK: - Private Methods

extension MemberProfileTableViewCell {

    private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat(rgbValue  & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
