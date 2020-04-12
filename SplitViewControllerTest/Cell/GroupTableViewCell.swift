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
    @IBOutlet weak var monitorButton: UIButton!
    
    
    private var monitorState: Bool?
    
    // Tableview的group列表中, 存放cell的row index值
    fileprivate var groupCellRowIndex: Int?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    @IBAction func monitorButtonPressed(_ sender: UIButton) {
        print("monitorButtonPressed")
        
        if let state = monitorState {
            (state == true) ? disableMonitor() : enableMonitor()
        }
        if let index = groupCellRowIndex {
           NotificationCenter.default.post(name: CHANGE_MONITOR_NOTIFY_KEY, object: self, userInfo: [CHANGE_MONITOR_USER_KEY: index])
        }
        
    }
    
}

// MARK: - Private Methods

extension GroupTableViewCell {
    private func updateUI() {
        disableColor()
        
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.clipsToBounds      = true
        groupImage.backgroundColor    = .lightGray
    }
}


// MARK: - Public Methods

extension GroupTableViewCell {
    func setMonitorState(_ state: Bool) {
        self.monitorState = state
    }
    
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
    
    func setGroupCellRowIndex(_ index: Int) {
        groupCellRowIndex = index
    }
    
    func enableMonitor() {
        monitorButton.setImage(UIImage(named: "icon_group_notify_on"), for: .normal)
    }
    
    func disableMonitor() {
        monitorButton.setImage(UIImage(named: "icon_group_notify_off"), for: .normal)
    }
    
    func enableColor() {
        trailingLine.isHidden = false
    }
    
    func disableColor() {
        trailingLine.isHidden = true
    }
    
}
