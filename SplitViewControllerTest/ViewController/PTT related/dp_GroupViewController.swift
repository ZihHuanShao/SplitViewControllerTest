//
//  dp_GroupViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/30.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class dp_GroupViewController: UIViewController {
    
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
    
    // Group Member Info Background View
    @IBOutlet weak var groupMemberInfoMaskView: UIView!
    @IBOutlet weak var groupMemberInfoView: UIView!
    @IBOutlet weak var blurGroupMemberImage: UIImageView!
    @IBOutlet weak var blurBackgroundView: UIView!
    @IBOutlet weak var groupMemberImage: UIImageView!
    @IBOutlet weak var groupMemberName: UILabel!
    @IBOutlet weak var connectionDurationTimeLabel: UILabel!
    @IBOutlet weak var groupMemberPttButtonImage: UIImageView!
    @IBOutlet weak var groupMemberPttButtonAnimationImage: UIImageView!
    @IBOutlet weak var groupMemberSipButton: UIButton!
    @IBOutlet weak var groupMemberVideoButton: UIButton!
    
    // Group Setting Info Mask View
    @IBOutlet weak var groupSettingInfoMaskView: UIView!
    @IBOutlet weak var groupSettingInfoView: UIView!
    @IBOutlet weak var groupSettingInfoTableView: UITableView!
    
    
    // MARK: - Properties
    
    fileprivate var dp_groupVo: dp_GroupVo?
    fileprivate var membersVo: [dp_MemberVo]?
    fileprivate var collectionViewDelegate: dp_GroupViewControllerCollectionoViewDelegate?
    fileprivate var callingType = GroupMemberCallingType.PTT
    fileprivate var groupSettingInfTableViewDelegate: dp_GroupViewControllerGroupSettingInfoTableViewDelegate?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDataSource()
        updateUI()
        resetGroupSettingInfoViewUI()
        resetGroupMemberInfoViewUI()
        updateGesture()
    }
    
    // MARK: - Actions
    
    //
    // groupSettingButton
    //
    
    @IBAction func groupSettingButtonPressed(_ sender: UIButton) {
        print("groupSettingButtonPressed")
        showGroupSettingInfoView(dp_groupVo: dp_groupVo)
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
    // GroupMemberPttButton
    //
    
    @IBAction func groupMemberPttButtonTouchDown(_ sender: UIButton) {
        if (callingType == .SIP_CALL || callingType == .VIDEO) {
            updateGroupMemberHangUpImage(type: .PRESSED)
        } else {
            updateGroupMemberPttButtonImage(type: .PRESSED)
        }
    }
    
    @IBAction func groupMemberPttButtonTouchDragExit(_ sender: UIButton) {
        if (callingType == .SIP_CALL || callingType == .VIDEO) {
            updateGroupMemberHangUpImage(type: .AWAY)
        } else {
            updateGroupMemberPttButtonImage(type: .AWAY)
        }
    }
    
    @IBAction func groupMemberPttButtonTouchUpInside(_ sender: UIButton) {
        if (callingType == .SIP_CALL || callingType == .VIDEO) {
            print("Hang Up")
            updateGroupMemberCallingControlUnits(type: .AWAY)
            updateGroupMemberHangUpImage(type: .AWAY)
            updateGroupMemberPttButtonImage(type: .AWAY)
            callingType = .PTT
        } else {
            updateGroupMemberPttButtonImage(type: .AWAY)
        }
    }

    //
    // groupMemberSipButton (Sip/ Mute)
    //
    
    @IBAction func groupMemberSipButtonPressed(_ sender: UIButton) {
        if callingType == .SIP_CALL {
            print("Mute")
        } else {
            updateGroupMemberCallingControlUnits(type: .PRESSED)
            callingType = .SIP_CALL
        }
    }

    //
    // GroupMemberVideoButton (Video/ Speaker)
    //
    
    @IBAction func GroupMemberVideoButtonPressed(_ sender: UIButton) {
        if callingType == .VIDEO {
            print("Speaker")
        } else {
            updateGroupMemberCallingControlUnits(type: .PRESSED)
            callingType = .VIDEO
        }
    }
    
}

// MARK: - Public Methods
extension dp_GroupViewController {
    func updateGroupVo(_ dp_groupVo: dp_GroupVo) {
        self.dp_groupVo = dp_groupVo
    }
}

// MARK: - Private Methods
extension dp_GroupViewController {
    private func updateDataSource() {
        collectionViewDelegate = dp_GroupViewControllerCollectionoViewDelegate(dp_groupViewController: self, collectionView: collectionView)
        
        groupSettingInfTableViewDelegate = dp_GroupViewControllerGroupSettingInfoTableViewDelegate(dp_groupViewController: self, tableView: groupSettingInfoTableView)
    }
    
    private func updateUI() {
        //
        // collectionViewDelegate
        //
        
        guard let gVo = dp_groupVo else {
            return
        }
        
        groupNameLabel.text = gVo.name
        (gVo.monitorState == true) ? enableMonitor() : disableMonitor()

        
        collectionViewDelegate?.registerCell(cellName: DP_GROUP_COLLECTION_VIEW_CELL, cellId: DP_GROUP_COLLECTION_VIEW_CELL)
        
        
        // group有幾個member, 就產生幾個cell
        collectionViewDelegate?.setGroupMembersCount(gVo.count ?? 0)
        
        var count = gVo.count ?? 0
        if count > 0 {
            membersVo = [dp_MemberVo]()
            while (count > 0) {
                membersVo?.append(dp_MemberVo.init(name: String(count)))
                count -= 1
            }
        }
                
        if let _membersVo = membersVo {
            collectionViewDelegate?.updateMembersVo(_membersVo)
        }
        
        //
        // groupSettingInfTableViewDelegate
        //
        
        groupSettingInfTableViewDelegate?.registerCell(cellName: DP_GROUP_SETTING_INFO_TABLE_VIEW_CELL, cellId: DP_GROUP_SETTING_INFO_TABLE_VIEW_CELL)
        
        
        // reload UI
        collectionViewDelegate?.reloadUI()
        groupSettingInfTableViewDelegate?.reloadUI()
    }
    
    private func resetGroupSettingInfoViewUI() {
        groupSettingInfoMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        // 全畫面遮罩: 預設隱藏, 點擊設定才會顯示
        groupSettingInfoMaskView.isHidden = true
    }
    
    private func resetGroupMemberInfoViewUI() {
        groupMemberInfoMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        // 通話時間: 預設隱藏, 撥號有接通才會顯示
        connectionDurationTimeLabel.isHidden = true
        
        // Sip與Video圖示: 預設顯示, 有撥號才會改變圖示
        groupMemberSipButton.setImage(UIImage(named: "btn_profile_call"), for: .normal)
        groupMemberVideoButton.setImage(UIImage(named: "btn_profile_video"), for: .normal)
        
        // 全畫面遮罩: 預設隱藏, 點擊成員才會顯示
        groupMemberInfoMaskView.isHidden = true
    }
    
    private func updateGesture() {
        //
        // groupMemberInfo
        //
        
        groupMemberInfoMaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissGroupMemberInfoMaskView)))
        
        let groupMemberInfoViewTap = UITapGestureRecognizer(target: self, action: #selector(keepGroupMemberInfoView))
        groupMemberInfoViewTap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        groupMemberInfoView.addGestureRecognizer(groupMemberInfoViewTap)
        
        //
        // groupSettingInfo
        //
        
        groupSettingInfoMaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissGroupSettingInfoMaskView)))
        
        let groupSettingInfoViewTap = UITapGestureRecognizer(target: self, action: #selector(keepGroupSettingInfoView))
        groupSettingInfoViewTap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        groupSettingInfoView.addGestureRecognizer(groupSettingInfoViewTap)
        
    }
    
    private func keepViewFront() {
        // do nothing
        // 點擊到焦點畫面不應該被dismiss, 做一個空的function擋
    }
    
    private func showGroupSettingInfoView(dp_groupVo: dp_GroupVo?) {
        if let monitorState = dp_groupVo?.monitorState {
            if monitorState {
                groupSettingInfTableViewDelegate?.enableMonitorButton()
            } else {
                groupSettingInfTableViewDelegate?.disableMonitorButton()
            }
        }
        groupSettingInfTableViewDelegate?.reloadUI()
        groupSettingInfoMaskView.isHidden = false
    }
    
    private func showGroupMemberInfoView(dp_memberVo: dp_MemberVo?) {
        
        var imageName = String()
        if let imgName = dp_memberVo?.imageName, imgName != "" {
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
        groupMemberName.text = dp_memberVo?.name ?? ""
        
        groupMemberInfoMaskView.isHidden = false
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
    
    // Ptt發話時, 更新UI及動畫
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
    
    // 點擊文字訊息, 更新UI
    private func updateChatButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            chatButtonImage.image = UIImage(named: "btn_chat_pressed")
            
        case .AWAY:
            chatButtonImage.image = UIImage(named: "btn_chat_normal")
        }
    }
    
    // 當通話中掛斷時, 更新UI
    private func updateGroupMemberHangUpImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            groupMemberPttButtonImage.image = UIImage(named: "btn_call_end_pressed")
            
        case .AWAY:
            groupMemberPttButtonImage.image = UIImage(named: "btn_call_end_normal")
        }
    }
    
    // 當撥打Sip或Video時, 更新UI
    private func updateGroupMemberCallingControlUnits(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            groupMemberSipButton.setImage(UIImage(named: "btn_call_mut"), for: .normal)
            groupMemberVideoButton.setImage(UIImage(named: "btn_call_speaker"), for: .normal)
            groupMemberPttButtonImage.image = UIImage(named: "btn_call_end_normal")
            
        case .AWAY:
            groupMemberSipButton.setImage(UIImage(named: "btn_profile_call"), for: .normal)
            groupMemberVideoButton.setImage(UIImage(named: "btn_profile_video.png"), for: .normal)
        }
    }
    
    // Ptt發話時, 更新UI及動畫
    private func updateGroupMemberPttButtonImage(type: ButtonPressType) {
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

extension dp_GroupViewController {
    @objc func dissmissGroupMemberInfoMaskView() {
        groupMemberInfoMaskView.isHidden = true
    }
    
    @objc func keepGroupMemberInfoView() {
        keepViewFront()
    }
    
    @objc func  dissmissGroupSettingInfoMaskView() {
        groupSettingInfoMaskView.isHidden = true
    }
    
    @objc func keepGroupSettingInfoView() {
        keepViewFront()
    }
}


// MARK: - GroupViewControllerCollectionoViewDelegateExtend

extension dp_GroupViewController: GroupViewControllerCollectionoViewDelegateExtend {
    func didTapGroupMember(dp_memberVo: dp_MemberVo?) {
        resetGroupMemberInfoViewUI()
        showGroupMemberInfoView(dp_memberVo: dp_memberVo)
    }
}
