//
//  GroupTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/25.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupMemberCount: UILabel!
    @IBOutlet weak var groupDesc: UILabel!
    @IBOutlet weak var trailingLine: UIView!
    @IBOutlet weak var monitorImage: UIImageView!
    
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

extension GroupTableViewCell {
    func setGroupImage(name: String) {
        if let image = UIImage(named: name) {
            groupImage.image = image
        }
    }
    
    func setGroupName(name: String) {
        groupName.text = name
    }
    
    func setGroupMemberCount(_ count: Int) {
        groupMemberCount.text = "\(count)"
    }
    
    func setGroupDesc(desc: String) {
        groupDesc.text = desc
    }
    
    func setMonitorImage(name: String) {
        if let image = UIImage(named: name) {
            monitorImage.image = image
        }
    }
    
    func enableColor() {
        trailingLine.isHidden = false
    }
    
    func disableColor() {
        trailingLine.isHidden = true
    }
    
}
