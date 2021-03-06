//
//  dp_GroupDispatchTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_GroupDispatchTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupMemberCount: UILabel!
    @IBOutlet weak var groupDesc: UILabel!
    @IBOutlet weak var checkboxButtonView: UIButton!
    @IBOutlet weak var checkboxImage: UIImageView!
    
    // MARK: - Properties
    

    
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

extension dp_GroupDispatchTableViewCell {
    private func updateUI() {
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.clipsToBounds      = true
    }
}

// MARK: - Public Methods

extension dp_GroupDispatchTableViewCell {
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
    
    
    func enableCheckbox() {
        checkboxImage.image = UIImage(named: "icon_selected")
    }
    
    func disableCheckbox() {
        checkboxImage.image = UIImage(named: "icon_unselected")
    }

}
