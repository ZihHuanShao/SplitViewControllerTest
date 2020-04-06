//
//  MemberTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/26.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var onlineStatusImage: UIImageView!
    @IBOutlet weak var onlineDesc: UILabel!
    @IBOutlet weak var trailingLine: UIView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disableColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Public Methods

extension MemberTableViewCell {
    func setUserImage(name: String) {
        if let image = UIImage(named: name) {
            userImage.image = image
        }
    }
    
    func setUserName(name: String) {
        userName.text = name
    }
    
    func setOnlineStatusImage(name: String) {
        if let image = UIImage(named: name) {
            onlineStatusImage.image = image
        }
    }
    
    func setOnlineDesc(desc: String) {
        onlineDesc.text = desc
    }
    
    func enableColor() {
        trailingLine.isHidden = false
    }
    
    func disableColor() {
        trailingLine.isHidden = true
    }
}
