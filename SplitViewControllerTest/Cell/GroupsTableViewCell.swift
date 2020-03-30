//
//  GroupsTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/25.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupMemberCount: UILabel!
    @IBOutlet weak var groupDesc: UILabel!
    @IBOutlet weak var trailingLine: UIView!
    @IBOutlet weak var monitorIcon: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trailingLine.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Public Methods

extension GroupsTableViewCell {
    func enableColor() {
        trailingLine.isHidden = false
    }
    
    func disableColor() {
        trailingLine.isHidden = true
    }
    
    func enableMonitor() {
//        monitorIcon.image =
    }
    
    func disableMonitor() {
//        monitorIcon.image =
    }
    
    func updateGroupDate() {
        
    }

}
