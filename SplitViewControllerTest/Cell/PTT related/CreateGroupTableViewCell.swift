//
//  CreateGroupTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class CreateGroupTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updaetUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - Private Methods

extension CreateGroupTableViewCell {
    private func updaetUI() {
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds      = true
    }
}

// MARK: - Public Methods

extension CreateGroupTableViewCell {
    func setMemberName(name: String) {
        memberName.text = name
    }
}
