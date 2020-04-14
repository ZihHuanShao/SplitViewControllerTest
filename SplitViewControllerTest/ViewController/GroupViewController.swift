//
//  GroupViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/30.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monitorImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var pttButtonImage: UIImageView!
    @IBOutlet weak var chatButtonImage: UIImageView!
    @IBOutlet weak var pttButtonAnimationImage: UIImageView!
    
    // MARK: - Properties
    
    fileprivate var groupVo: GroupVo?
    fileprivate var membersVo: [MemberVo]?
    fileprivate var collectionViewDelegate: GroupCollectionoViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - Actions
    
    @IBAction func groupSettingButtonPressed(_ sender: UIButton) {
        print("groupSettingButtonPressed")
    }
    
    @IBAction func pttButtonTouchDown(_ sender: UIButton) {
        print("pttButtonPressedTouchDown")
        disablePttAnimation()
    }
    
    @IBAction func pttButtonTouchDragExit(_ sender: UIButton) {
        print("pttButtonTouchDragExit")
        disablePttAnimation()
    }
    
    @IBAction func pttButtonTouchUpInside(_ sender: UIButton) {
        print("pttButtonPressed")
        enablePttAnimation()
    }
    
    @IBAction func chatButtonPressed(_ sender: UIButton) {
        print("chatButtonPressed")
        
    }
    
}

// MARK: - Public Methods
extension GroupViewController {
    func updateGroupVo(_ groupVo: GroupVo) {
        self.groupVo = groupVo
    }
}

// MARK: - Private Methods
extension GroupViewController {
    private func updateUI() {
        
        guard let gVo = groupVo else {
            return
        }
        
        groupNameLabel.text = gVo.name
        (gVo.notifyState == true) ? enableMonitor() : disableMonitor()

        collectionViewDelegate = GroupCollectionoViewDelegate(groupViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: GROUP_COLLECTION_VIEW_CELL, cellId: GROUP_COLLECTION_VIEW_CELL)
        
        
        // group共有幾個member, 就產生幾個cell
        collectionViewDelegate?.setGroupMembersCount(gVo.count ?? 0)
        
        var count = gVo.count ?? 0
        if count > 0 {
            membersVo = [MemberVo]()
            while (count > 0) {
                membersVo?.append(MemberVo.init(name: String(count * 10000)))
                count -= 1
            }
        }
        
        
        if let _membersVo = membersVo {
            collectionViewDelegate?.updateMembersVo(_membersVo)
        }
        
        collectionViewDelegate?.reloadUI()
    }
    
    private func enablePttAnimation() {
        pttButtonAnimationImage.image = UIImage.animatedImage(with: PTT_ANIMATION_IMAGES, duration: 1)
        pttButtonAnimationImage.contentMode = .scaleAspectFit
    }
    
    private func disablePttAnimation() {
        pttButtonAnimationImage.image = nil
        pttButtonAnimationImage.animationImages = nil
    }
    
    private func enableMonitor() {
        monitorImage.image = UIImage(named: "icon_titile_notify_on")
    }
    
    private func disableMonitor() {
        monitorImage.image = UIImage(named: "icon_titile_notify_off")
    }
}
