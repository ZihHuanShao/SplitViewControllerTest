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
    
    // Bottom View
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Top View
    @IBOutlet weak var monitorImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    // Chat View
    @IBOutlet weak var chatButtonImage: UIImageView!
    
    // PTT View
    @IBOutlet weak var pttButtonImage: UIImageView!
    @IBOutlet weak var pttButtonAnimationImage: UIImageView!
    
    // Group Member View
    @IBOutlet weak var groupMemberInfoView: UIView!
    @IBOutlet weak var groupMemberView: UIView!
    @IBOutlet weak var blurGroupMemberImage: UIImageView!
    @IBOutlet weak var blurBackgroundView: UIView!
    @IBOutlet weak var groupMemberImage: UIImageView!
    @IBOutlet weak var groupMemberName: UILabel!
    @IBOutlet weak var connectionDurationTimeLabel: UILabel!
    @IBOutlet weak var groupMemberSipButton: UIButton!
    @IBOutlet weak var groupMemberPttButtonImage: UIImageView!
    @IBOutlet weak var groupMemberPttButtonAnimationImage: UIImageView!
    @IBOutlet weak var GroupMemberVideoButton: UIButton!
    
    
    // MARK: - Properties
    
    fileprivate var groupVo: GroupVo?
    fileprivate var membersVo: [MemberVo]?
    fileprivate var collectionViewDelegate: GroupViewControllerCollectionoViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateGroupMemberViewUI()
        updateGesture()
    }
    
    // MARK: - Actions
    
    //
    // groupSettingButton
    //
    
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
    
    //
    // GroupMemberButton
    //
    
    @IBAction func groupMemberPttButtonTouchDown(_ sender: UIButton) {
        updateGroupMemberButtonImage(type: .PRESSED)
    }
    
    @IBAction func groupMemberPttButtonTouchDragExit(_ sender: UIButton) {
        updateGroupMemberButtonImage(type: .AWAY)
    }
    
    @IBAction func groupMemberPttButtonTouchUpInside(_ sender: UIButton) {
        updateGroupMemberButtonImage(type: .AWAY)
    }

    
    //
    // groupMemberSipButton
    //
    
    @IBAction func groupMemberSipButtonPressed(_ sender: UIButton) {
        
    }

    //
    // GroupMemberVideoButton
    //
    
    @IBAction func GroupMemberVideoButtonPressed(_ sender: UIButton) {
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
    
    private func updateGroupMemberViewUI() {
        groupMemberView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 預設隱藏, 撥號有接通才會顯示
        connectionDurationTimeLabel.isHidden = true
        
        // 預設隱藏, 點擊成員才會顯示
        groupMemberView.isHidden = true
    }
    
    private func updateGesture() {
        groupMemberView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissGroupMemberView)))
        
        groupMemberInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keepViewFront)))
    }
    
    private func showGroupMemberView(memberVo: MemberVo?) {
        
        var imageName = String()
        if let imgName = memberVo?.imageName, imgName != "" {
            imageName = imgName
        } else {
            imageName = "sticker_contact.png"
        }
        
        let memberImage = UIImage(named: imageName)!
        
        // 背景圖片(模糊化)
        blurGroupMemberImage.image = getImageBlurred(image: memberImage)
        
        // 背景顏色
        blurBackgroundView.backgroundColor = UIColorFromRGB(rgbValue: UInt(GROUP_MEMBER_BLUR_BACKGROUND_COLOR)).withAlphaComponent(CGFloat(GROUP_MEMBER_BLUR_BACKGROUND_COLOR_ALPHA))
        
        // 成員圖片
        groupMemberImage.image = memberImage
        
        // 成員名字
        groupMemberName.text = memberVo?.name ?? ""
        
        groupMemberView.isHidden = false
    }
    
    // 取得模糊化後的圖片
    private func getImageBlurred(image: UIImage) -> UIImage {
        
        let inputImage =  CIImage(image: image)
        
        // 使用高斯模糊濾鏡
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        
        // 設置模糊值（越大越模糊）
        filter.setValue(Float(5), forKey: kCIInputRadiusKey)
        
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: image.size)
        let cgImage = CIContext(options: nil).createCGImage(outputCIImage, from: rect)
        
        return UIImage(cgImage: cgImage!)
    }
    
    private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat(rgbValue  & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
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
    
    private func updateGroupMemberButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            groupMemberPttButtonImage.image = UIImage(named: "btn_ptt_pressed")
            groupMemberPttButtonAnimationImage.image = UIImage.animatedImage(with: GROUP_MEMBER_PTT_ANIMATION_IMAGES, duration: 1)
            groupMemberPttButtonAnimationImage.contentMode = .scaleAspectFit
            
        case .AWAY:
            groupMemberPttButtonImage.image = UIImage(named: "btn_ptt_normal")
            groupMemberPttButtonAnimationImage.image = nil
            groupMemberPttButtonAnimationImage.animationImages = nil
        }
    }
}

// MARK: - Event Methods

extension GroupViewController {
    @objc func dismissGroupMemberView() {
        groupMemberView.isHidden = true
    }
    
    @objc func keepViewFront() {
        // do nothing
        // 點擊群組成員的畫面不應該被dismiss, 做一個空的function擋
    }
}


// MARK: - GroupViewControllerCollectionoViewDelegateExtend

extension GroupViewController: GroupViewControllerCollectionoViewDelegateExtend {
    func didTapGroupMember(memberVo: MemberVo?) {
        showGroupMemberView(memberVo: memberVo)
    }
}
