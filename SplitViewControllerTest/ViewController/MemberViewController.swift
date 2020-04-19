//
//  MemberViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/31.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    
    @IBOutlet weak var pttButtonAnimationImage: UIImageView!
    @IBOutlet weak var pttButtonImage: UIImageView!
    
    
    @IBOutlet weak var videoButtonImage: UIImageView!
    @IBOutlet weak var sipCallButtonImage: UIImageView!
    
    @IBOutlet weak var chatButtonImage: UIImageView!
    
    
    // tableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    fileprivate var memberVo: MemberVo?
    
    // tableview
    fileprivate var tableViewDelegate: MemberViewControllerTableViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Actions
    
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
    // videoButton
    //
    
    @IBAction func videoButtonTouchDown(_ sender: UIButton) {
        updateVideoButtonImage(type: .PRESSED)
    }
    
    @IBAction func videoButtonTouchDragExit(_ sender: UIButton) {
        updateVideoButtonImage(type: .AWAY)
    }
    
    @IBAction func videoButtonTouchUpInside(_ sender: UIButton) {
        updateVideoButtonImage(type: .AWAY)
    }
    
    //
    // sipCallButton
    //
    
    @IBAction func sipCallButtonTouchDown(_ sender: UIButton) {
        updateSipCallButtonImage(type: .PRESSED)
    }
    
    @IBAction func sipCallButtonTouchDragExit(_ sender: UIButton) {
        updateSipCallButtonImage(type: .AWAY)
    }
    
    @IBAction func sipCallButtonTouchUpInside(_ sender: UIButton) {
        updateSipCallButtonImage(type: .AWAY)
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

extension MemberViewController {
    func updateMemberVo(_ memberVo: MemberVo) {
        self.memberVo = memberVo
    }
    
    func updateUI() {
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds      = true
        
        guard let mVo = memberVo else {
            return
        }
        
        memberNameLabel.text = mVo.name
        memberImage.image = UIImage(named: mVo.imageName ?? "sticker_contact.png")
        
        tableViewDelegate = MemberViewControllerTableViewDelegate(memberViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: MEMBER_PROFILE_TABLE_VIEW_CELL, cellId: MEMBER_PROFILE_TABLE_VIEW_CELL)
        if let _memberVo = memberVo {
            tableViewDelegate?.updateMemberVo(_memberVo)
        }
        
        tableViewDelegate?.reloadUI()
    }
}

// MARK: - Private Methods

extension MemberViewController {

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
    
    private func updateVideoButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            videoButtonImage.image = UIImage(named: "btn_video_pressed")
            
        case .AWAY:
            videoButtonImage.image = UIImage(named: "btn_video_normal")
        }
    }
    
    private func updateSipCallButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            sipCallButtonImage.image = UIImage(named: "btn_sip_pressed")
            
        case .AWAY:
            sipCallButtonImage.image = UIImage(named: "btn_sip_normal")
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
