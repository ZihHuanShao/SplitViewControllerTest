//
//  GroupCollectionViewCell.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/30.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var soundWaveImage: UIImageView!
    @IBOutlet weak var onlineStatusImage: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

// MARK: - Public Methods

extension GroupCollectionViewCell {
    func setMemberImage(name: String) {
        if let image = UIImage(named: name) {
            memberImage.image = image
        }
    }
    
    func setMemberName(name: String) {
        memberName.text = name
    }
    
    func setSpeakerImage(name: String) {
        if let image = UIImage(named: name) {
            speakerImage.image = image
        }
    }
    
    func setSoundWaveImage(name: String) {
        if let image = UIImage(named: name) {
            soundWaveImage.image = image
        }
    }
    
    func setOnlineStatusImage(name: String) {
        if let image = UIImage(named: name) {
            onlineStatusImage.image = image
        }
    }
    
}
