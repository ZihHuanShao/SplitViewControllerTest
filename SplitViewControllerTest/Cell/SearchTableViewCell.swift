//
//  SearchTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/25.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var searchTextField: UITextField!

    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - UITextFieldDelegate

extension SearchTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
