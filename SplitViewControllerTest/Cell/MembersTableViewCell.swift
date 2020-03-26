//
//  MembersTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/26.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MembersTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var onlineStatus: UIImageView!
    @IBOutlet weak var onlineDesc: UILabel!
    @IBOutlet weak var trailingLine: UIView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trailingLine.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MembersTableViewCell {
    func enableColor() {
        trailingLine.isHidden = false
    }
    
    func disableColor() {
        trailingLine.isHidden = true
    }
}
