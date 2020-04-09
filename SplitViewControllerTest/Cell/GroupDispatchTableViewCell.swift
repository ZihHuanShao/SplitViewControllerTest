//
//  GroupDispatchTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class GroupDispatchTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupMemberCount: UILabel!
    @IBOutlet weak var groupDesc: UILabel!
    @IBOutlet weak var checkboxButtonView: UIButton!
    @IBOutlet weak var checkboxImage: UIImageView!
    
    // MARK: - Properties
    
    fileprivate var isChecked: Bool? = nil
    
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

extension GroupDispatchTableViewCell {
    private func updateUI() {
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.clipsToBounds      = true
        groupImage.backgroundColor    = .lightGray
        
        if let _isChecked = isChecked {
            (_isChecked == true) ? enableCheckbox() : disableCheckbox()
        } else {
            disableCheckbox()
        }
    }
}

// MARK: - Public Methods

extension GroupDispatchTableViewCell {
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
    
    func triggerCheckbox() {
        
        if let _isChecked = isChecked {
            (_isChecked == true) ? disableCheckbox() : enableCheckbox()
        } else {
            enableCheckbox()
        }
    }
    
    func enableCheckbox() {
        isChecked = true
        checkboxImage.image = UIImage(named: "icon_selected")
    }
    
    func disableCheckbox() {
        isChecked = false
        checkboxImage.image = UIImage(named: "icon_unselected")
    }

}
