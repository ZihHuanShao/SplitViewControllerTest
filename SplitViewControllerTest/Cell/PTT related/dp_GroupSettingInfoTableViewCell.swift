//
//  dp_GroupSettingInfoTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/23.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_GroupSettingInfoTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var indicatorImage: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    @IBAction func switchButtonPressed(_ sender: UIButton) {
        
    }
}

// MARK: - Public Methods

extension dp_GroupSettingInfoTableViewCell {
    func enableSwitchButton() {
        switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
    }
    
    func disableSwitchButton() {
        switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
    }
    
    func updateCell(_ type: GroupSettingType) {
        switch type {
            
        case .MONITOR_MODE:
            switchButton.isHidden = false
            indicatorImage.isHidden = true
            itemImage.image = UIImage(named: "icon_groupset_notify")
            itemTitle.text = str_group_monitorMode
            itemDesc.text = str_group_monitorModeDesc
            backgroundImage.image = UIImage(named: "bg_groupset_alert2")

        case .EDIT_GROUP:
            switchButton.isHidden = true
            indicatorImage.isHidden = false
            itemImage.image = UIImage(named: "icon_groupset_set")
            itemTitle.text = str_group_editGroup
            itemDesc.text = str_group_editGroupDesc
            backgroundImage.image = UIImage(named: "bg_groupset_alert4")
            
        }
    }
}
