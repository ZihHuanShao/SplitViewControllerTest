//
//  GroupMembersTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/25.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class GroupMembersTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupMemberCount: UILabel!
    @IBOutlet weak var groupDesc: UILabel!
    @IBOutlet weak var trailingLine: UIView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
         trailingLine.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension GroupMembersTableViewCell {
    func enableColor() {
        trailingLine.backgroundColor = .red
    }
    
    func disableColor() {
        trailingLine.backgroundColor = .clear
    }
}
