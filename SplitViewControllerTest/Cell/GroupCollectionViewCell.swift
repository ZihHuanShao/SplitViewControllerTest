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
    @IBOutlet weak var soundWaveImage: UIImageView!
    @IBOutlet weak var onlineStatusImage: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - Public Methods

extension GroupCollectionViewCell {

}

// MARK: - Public Methods

extension GroupCollectionViewCell {
    
    func enableSoundWaveAnimation() {
        soundWaveImage.image = UIImage.animatedImage(with: PTT_SOUND_WAVE_ANIMATION_IMAGES, duration: 1)
        soundWaveImage.contentMode = .scaleAspectFit
    }
    
    func disableSoundWaveAnimation() {
        soundWaveImage.image = nil
        soundWaveImage.animationImages = nil
    }
    
    func setMemberImage(name: String) {
        if let image = UIImage(named: name) {
            memberImage.image = image
        }
    }
    
    func setMemberName(name: String) {
        memberName.text = name
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
