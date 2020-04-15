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
    fileprivate var tableRowIndex: Int?
    
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
        if let _tableRowIndex = tableRowIndex {
           NotificationCenter.default.post(name: DROP_SELECTED_GROUP_TABLE_CELL_NOTIFY_KEY, object: self, userInfo: [DROP_SELECTED_GROUP_TABLE_CELL_USER_KEY: _tableRowIndex])
        }
        
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
    
    func setTableRowIndex(_ tableRowIndex: Int) {
        self.tableRowIndex = tableRowIndex
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
