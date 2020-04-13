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
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Private Methods

extension MemberTableViewCell {
    private func updateUI() {
        disableColor()
        
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds      = true
        userImage.backgroundColor    = .lightGray
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
    
    func setOnlineState(type: OnlineType) {
        switch type {
            
        case .AVAILABLE:
            setOnlineStatusImage(name: "icon_status_online")
            setOnlineDesc(desc: "有空")
            
        case .BUSY:
            setOnlineStatusImage(name: "icon_status_busy")
            setOnlineDesc(desc: "忙碌")
            
        case .NO_DISTURB:
            setOnlineStatusImage(name: "icon_status_nodisturbing")
            setOnlineDesc(desc: "勿擾")
            
        case .OFFLINE:
            setOnlineStatusImage(name: "icon_status_offline")
            setOnlineDesc(desc: "離線")
        }
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
