//
//  dp_AddMemberCollectionViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_AddMemberCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    
    // MARK: - Properties
    
    // Tableview的member列表中, 存放cell的row index值
    fileprivate var tableRowIndex: Int?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    deinit {
        
    }
    
    // MARK: - Actions
    
    @IBAction func dropoutButtonPressed(_ sender: UIButton) {
        print("dropoutButtonPressed")
        if let _tableRowIndex = tableRowIndex {
            NotificationCenter.default.post(name: DROP_SELECTED_MEMBER_TABLE_CELL_NOTIFY_KEY, object: self, userInfo: [DROP_SELECTED_MEMBER_TABLE_CELL_USER_KEY: _tableRowIndex])
        }
        
    }
    
}

// MARK: - Public Methods

extension dp_AddMemberCollectionViewCell {
    func setMemberImage(name: String) {
        if let image = UIImage(named: name) {
            memberImage.image = image
        }
    }
    
    func setMemberName(name: String?) {
        if let _name = name {
            memberName.text = _name
        }
    }
    
    func setTableRowIndex(_ tableRowIndex: Int) {
        self.tableRowIndex = tableRowIndex
    }
}

// MARK: - Private Methods

extension dp_AddMemberCollectionViewCell {
    private func updateUI() {
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds      = true
    }

}
