//
//  GroupDispatchCollectionViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/8.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class GroupDispatchCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    
    // MARK: - Properties
    
    // Tableview的group列表中, 存放cell的row index值
    fileprivate var cellRowIndex = Int()
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    deinit {
        
    }
    
    // MARK: - Actions
    
    @IBAction func dropoutButtonPressed(_ sender: UIButton) {
        print("dropoutButtonPressed")
        NotificationCenter.default.post(name: DROP_SELECTED_GROUP_NOTIFY_KEY, object: self, userInfo: [REMOVE_SELECTED_GROUP_BUTTON_NOTIFY_USER_KEY: cellRowIndex])
    }
    
}

// MARK: - Public Methods

extension GroupDispatchCollectionViewCell {
    func setGroupImage(name: String) {
        if let image = UIImage(named: name) {
            groupImage.image = image
        }
    }
    
    func setGroupName(name: String?) {
        if let _name = name {
            groupName.text = _name
        }
    }
    
    func setRowIndex(_ tableviewCellIndexPathRow: Int) {
        cellRowIndex = tableviewCellIndexPathRow
    }
}

// MARK: - Private Methods

extension GroupDispatchCollectionViewCell {
    private func updateUI() {
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.clipsToBounds      = true
        groupImage.backgroundColor    = .lightGray
    }

}
