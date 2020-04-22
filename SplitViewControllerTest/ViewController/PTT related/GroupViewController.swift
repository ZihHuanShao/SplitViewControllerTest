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
    @IBOutlet weak var groupMemberView: UIView!
    
    // MARK: - Properties
    
    fileprivate var groupVo: GroupVo?
    fileprivate var membersVo: [MemberVo]?
    fileprivate var collectionViewDelegate: GroupViewControllerCollectionoViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupMemberView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        updateUI()
    }
    
    // MARK: - Actions
    
    @IBAction func groupSettingButtonPressed(_ sender: UIButton) {
        print("groupSettingButtonPressed")
    }
    
    //
    // pttButton
    //
    
    @IBAction func pttButtonTouchDown(_ sender: UIButton) {
        updatePttButtonImage(type: .PRESSED)
    }
    
    @IBAction func pttButtonTouchDragExit(_ sender: UIButton) {
        updatePttButtonImage(type: .AWAY)
    }
    
    @IBAction func pttButtonTouchUpInside(_ sender: UIButton) {
        updatePttButtonImage(type: .AWAY)
    }
    
    //
    // chatButton
    //
    
    @IBAction func chatButtonTouchDown(_ sender: UIButton) {
        updateChatButtonImage(type: .PRESSED)
    }
    
    @IBAction func chatButtonTouchDragExit(_ sender: UIButton) {
        updateChatButtonImage(type: .AWAY)
    }
    
    @IBAction func chatButtonTouchUpInside(_ sender: UIButton) {
        updateChatButtonImage(type: .AWAY)
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
        (gVo.monitorState == true) ? enableMonitor() : disableMonitor()

        collectionViewDelegate = GroupViewControllerCollectionoViewDelegate(groupViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: GROUP_COLLECTION_VIEW_CELL, cellId: GROUP_COLLECTION_VIEW_CELL)
        
        
        // group有幾個member, 就產生幾個cell
        collectionViewDelegate?.setGroupMembersCount(gVo.count ?? 0)
        
        var count = gVo.count ?? 0
        if count > 0 {
            membersVo = [MemberVo]()
            while (count > 0) {
                membersVo?.append(MemberVo.init(name: String(count)))
                count -= 1
            }
        }
                
        if let _membersVo = membersVo {
            collectionViewDelegate?.updateMembersVo(_membersVo)
        }
        
        collectionViewDelegate?.reloadUI()
    }
    
    private func enableMonitor() {
        monitorImage.image = UIImage(named: "icon_titile_notify_on")
    }
    
    private func disableMonitor() {
        monitorImage.image = UIImage(named: "icon_titile_notify_off")
    }
    
    private func updatePttButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            pttButtonImage.image = UIImage(named: "btn_ptt_pressed")
            pttButtonAnimationImage.image = UIImage.animatedImage(with: PTT_ANIMATION_IMAGES, duration: 1)
            pttButtonAnimationImage.contentMode = .scaleAspectFit
            
        case .AWAY:
            pttButtonImage.image = UIImage(named: "btn_ptt_normal")
            pttButtonAnimationImage.image = nil
            pttButtonAnimationImage.animationImages = nil
        }
    }
    
    private func updateChatButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            chatButtonImage.image = UIImage(named: "btn_chat_pressed")
            
        case .AWAY:
            chatButtonImage.image = UIImage(named: "btn_chat_normal")
        }
    }
}
