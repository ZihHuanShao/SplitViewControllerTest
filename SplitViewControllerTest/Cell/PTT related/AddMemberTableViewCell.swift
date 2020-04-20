//
//  AddMemberTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class AddMemberTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    
    @IBOutlet weak var checkboxButtonView: UIButton!
    @IBOutlet weak var checkboxImage: UIImageView!
    
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

extension AddMemberTableViewCell {
    private func updateUI() {
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds      = true
    }
}

// MARK: - Public Methods

extension AddMemberTableViewCell {
    func setMemberImage(name: String) {
        if let image = UIImage(named: name) {
            memberImage.image = image
        }
    }
    
    func setMemberName(name: String) {
        memberName.text = name
    }
    
    
    func enableCheckbox() {
        checkboxImage.image = UIImage(named: "icon_selected")
    }
    
    func disableCheckbox() {
        checkboxImage.image = UIImage(named: "icon_unselected")
    }

}
