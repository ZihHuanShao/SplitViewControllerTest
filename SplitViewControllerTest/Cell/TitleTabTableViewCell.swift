//
//  TitleTabTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/25.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class TitleTabTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var leftBottomLine: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftContentView: UIView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightBottomLine: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightContentView: UIView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func leftViewButtonPressed(_ sender: UIButton) {
        leftLabel.textColor      = .red
        rightLabel.textColor     = .lightGray
        leftBottomLine.isHidden  = false
        rightBottomLine.isHidden = true
        print("leftViewButtonPressed")
    }
    
    @IBAction func rightViewButtonPressed(_ sender: UIButton) {
        leftLabel.textColor      = .lightGray
        rightLabel.textColor     = .red
        leftBottomLine.isHidden  = true
        rightBottomLine.isHidden = false
        print("rightViewButtonPressed")
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftLabel.textColor  = .red
        rightLabel.textColor = .lightGray
        
        leftImage.image  = UIImage(named: "warning-icon")
        leftLabel.text   = "群組"
        rightImage.image = UIImage(named: "warning-icon")
        rightLabel.text  = "聯絡人"
        
        leftBottomLine.isHidden = false
        rightBottomLine.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
