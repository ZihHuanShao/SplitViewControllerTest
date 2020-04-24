//
//  GroupSettingInfoTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/23.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class GroupSettingInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var infoContentView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var indicatorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchButtonPressed(_ sender: UIButton) {
    }
}

extension GroupSettingInfoTableViewCell {
    func updateCell(_ type: GroupSettingType) {
        switch type {
            
        case .DUMMY_HEAD:
//            self.contentView.backgroundColor = .clear
            infoContentView.isHidden = true
            backgroundImage.image = UIImage(named: "bg_groupset_alert1")
            
            
        case .MONITOR_MODE:
            infoContentView.isHidden = false
            switchButton.isHidden = false
            indicatorImage.isHidden = true
            itemImage.image = UIImage(named: "icon_groupset_notify")
            itemTitle.text = "監聽模式"
            itemDesc.text = "接收到新訊息時，系統直接播放語音"
            backgroundImage.image = UIImage(named: "bg_groupset_alert2")
//            backgroundImage.backgroundColor = .orange
        
        case .DUMMY_CONTENT:
            infoContentView.isHidden = false
            switchButton.isHidden = false
            indicatorImage.isHidden = true
            itemImage.image = UIImage(named: "icon_groupset_notify")
            itemTitle.text = "XX模式"
            itemDesc.text = "ABCDEFG"
            backgroundImage.image = UIImage(named: "bg_groupset_alert3")
//            backgroundImage.backgroundColor = .blue
            
        case .EDIT_GROUP:
            infoContentView.isHidden = false
            switchButton.isHidden = true
            indicatorImage.isHidden = false
            itemImage.image = UIImage(named: "icon_groupset_set")
            itemTitle.text = "編輯群組"
            itemDesc.text = "進行群組名稱、成員等相關設定"
            backgroundImage.image = UIImage(named: "bg_groupset_alert4")
//            backgroundImage.backgroundColor = .red
//            self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
            
        }
    }
}
