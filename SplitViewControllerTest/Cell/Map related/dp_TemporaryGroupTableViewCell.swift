//
//  dp_TemporaryGroupTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_TemporaryGroupTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var onlineStatusImage: UIImageView!
    @IBOutlet weak var onlineDesc: UILabel!
    
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

extension dp_TemporaryGroupTableViewCell {
    private func updateUI() {
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds      = true
    }
}

// MARK: - Public Methods

extension dp_TemporaryGroupTableViewCell {
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
}
