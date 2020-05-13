//
//  DispEditElectrFenceViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/27.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit
import MapKit

class DispEditElectrFenceViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var customElectrFenceTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var finishImage: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var colorBarBackgroundView: UIView!
    @IBOutlet weak var colorBarButton: UIButton!
    
    // tableView
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    var tableViewDelegate: DispEditElectrFenceViewControllerTableViewDelegate?
    var currentElectrFenceVo: ElectrFenceVo?
    var newElectrFenceCoordinates: [CLLocationCoordinate2D]?
    var displayType = EditElectrFenceDisplayType.NONE
    var electrFenceColor = UInt()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateDataSource()
        addObserver()
        updateUI()
        updateGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeObserver()
    }
    
    // MARK: - Actions
    
    // [finishButton]
    
    @IBAction func finishButtonTouchDown(_ sender: UIButton) {
        updatefinishButtonImage(type: .PRESSED)
    }
    
    @IBAction func finishButtonTouchDragExit(_ sender: UIButton) {
        updatefinishButtonImage(type: .AWAY)
    }
    
    @IBAction func finishButtonTouchUpInside(_ sender: UIButton) {
        updatefinishButtonImage(type: .AWAY)
        
        currentElectrFenceVo?.title = nameTextField.text
        
        // 更新電子圍籬列表
        NotificationCenter.default.post(
            name: UPDATE_NEW_ELECTR_FENCE_VO_NOTIFY_KEY,
            object: self,
            userInfo: [UPDATE_NEW_ELECTR_FENCE_VO_USER_KEY: currentElectrFenceVo]
        )
        
        removeObserver()
        
    }
    
    @IBAction func colorBarButtonPressed(_ sender: UIButton) {
        print("colorBarButtonPressed")
        
        if !gVar.isHoldFormSheetView {
            gVar.isHoldFormSheetView = true
            
            // wait a moment before taking the screenshot
            let _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showEdidColorModalDelayed), userInfo: nil, repeats: false)
        }
    }
}

// MARK: - Public Methods

extension DispEditElectrFenceViewController {
    func setDisplayMode(type: EditElectrFenceDisplayType) {
        self.displayType = type
    }
    
    func updateNewElectrFenceCoordinates(_ coordinates: [CLLocationCoordinate2D]?) {
        self.newElectrFenceCoordinates = coordinates
    }
    
    func updateElectrFenceVo(electrFenceVo: ElectrFenceVo?) {
        self.currentElectrFenceVo = electrFenceVo
    }
}

// MARK: - Private Methods

extension DispEditElectrFenceViewController {
    private func updateDataSource() {
        
        if displayType == .CREATE {
            reloadDefaultElectrFenceVo()
        }
        
        tableViewDelegate = DispEditElectrFenceViewControllerTableViewDelegate(dispEditElectrFenceViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_EDIT_ELECTR_FENCE_TABLE_VIEW_CELL, cellId: DISP_EDIT_ELECTR_FENCE_TABLE_VIEW_CELL)
        
        // 兩種時機:
        // 1. 建立新的電子圍籬, 會從reloadDefaultElectrFenceVo()取得新的vo, 所以currentElectrFenceVo會有值
        // 2. 既有的電子圍籬, 會先更新currentElectrFenceVo
        if let electrFenceVo = currentElectrFenceVo {
            tableViewDelegate?.updateElectrFenceVo(electrFenceVo)
        }
        
        nameTextField.delegate = self
    }
    
    private func reloadDefaultElectrFenceVo() {
        let notifyTargetMemberVo = MemberVo(name: "調度員Maxkit")
        let preferGroupGroupVo = GroupVo(name: "緊急通報群組")
        
        currentElectrFenceVo = ElectrFenceVo(
            title: nameTextField.text ?? "",
            color: 0xFF0000,
            notifyTarget: notifyTargetMemberVo,
            autoSwitchPreferGroupEnabled: true,
            preferGroup: preferGroupGroupVo,
            enterAlarmEnabled: true,
            enterAlarmVoicePlayEnabled: true,
            enterAlarmVoice: "危險區域 請儘速離開",
            exitAlarmEnabled: true,
            exitAlarmVoicePlayEnabled: true,
            exitAlarmVoice: "您已離開 測試圍籬1",
            coordinates: newElectrFenceCoordinates
        )
    }
    
    private func updateUI() {
        
        // [Fixed String]
        
        nameLabel.text = str_dispEditElectrFence_name // 名稱
        colorLabel.text = str_dispEditElectrFence_colorName // 顏色
        finishButton.setTitle(str_dispEditElectrFence_finish, for: .normal) // 完成
        
        colorBarBackgroundView.layer.cornerRadius = 5
        colorBarBackgroundView.clipsToBounds = true
        colorBarButton.layer.cornerRadius = 5
        colorBarButton.clipsToBounds = true
        
        // [Custom String & UI]
        
        // 建立新的電子圍籬
        if displayType == .CREATE {
            customElectrFenceTitle.text = "新增電子圍籬"
            electrFenceColor = 0xFF0000
            colorBarButton.backgroundColor = UIColorFromRGB(colorValue: electrFenceColor)
        }
        // 編輯既有電子圍籬
        else if displayType == .EDIT {
            customElectrFenceTitle.text = str_dispEditElectrFence_customFenceNamePrefix + (currentElectrFenceVo?.title ?? "")
            electrFenceColor = currentElectrFenceVo?.color ?? 0xFF0000
            colorBarButton.backgroundColor = UIColorFromRGB(colorValue: electrFenceColor)
        }
        
        tableViewDelegate?.reloadUI()
    }
    
    private func UIColorFromRGB(colorValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((colorValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((colorValue & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat(colorValue  & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // EX: UInt(0xFF0A0B) 轉換 RGBColorCode(r:255, g:10, b:11)
    private func getRGBColor(colorValue: UInt) -> RGBColorCode {
        let rVal = Int((colorValue & 0xFF0000) >> 16) // 0xFF -> 255
        let gVal = Int((colorValue & 0x00FF00) >> 8)  // 0x0A -> 10
        let bVal = Int(colorValue & 0x0000FF)         // 0x0B -> 11
        
        return RGBColorCode(red: rVal, green: gVal, blue: bVal)
    }
    
    // EX: RGBColorCode(r:255, g:10, b:11) 轉換 UInt(0xFF0A0B)
    private func getUIntColor(rgbColor: RGBColorCode) -> UInt {
        let rHex = (UInt(rgbColor.red)   & 0xFF) << 16 // 255 -> 0xFF0000
        let gHex = (UInt(rgbColor.green) & 0xFF) << 8  // 10  -> 0x  000A
        let bHex = UInt(rgbColor.blue)   & 0xFF        // 11  -> 0x    0B
        
        return (rHex | gHex | bHex)
    }
    
    private func removeObserver() {
        if let _ = gVar.changeColorObserver {
            NotificationCenter.default.removeObserver(gVar.changeColorObserver!)
            gVar.changeColorObserver = nil
            print("removeObserver: changeColorObserver")
        }
        
        if let _ = gVar.autoSwitchPreferGroupChangedObserver {
            NotificationCenter.default.removeObserver(gVar.autoSwitchPreferGroupChangedObserver!)
            gVar.autoSwitchPreferGroupChangedObserver = nil
            print("removeObserver: switchChangedObserver")
        }
        
        if let _ = gVar.enterAlarmChangedObserver {
            NotificationCenter.default.removeObserver(gVar.enterAlarmChangedObserver!)
            gVar.enterAlarmChangedObserver = nil
            print("removeObserver: enterAlarmChangedObserver")
        }
        
        if let _ = gVar.enterAlarmVoicePlayChangedObserver {
            NotificationCenter.default.removeObserver(gVar.enterAlarmVoicePlayChangedObserver!)
            gVar.enterAlarmVoicePlayChangedObserver = nil
            print("removeObserver: enterAlarmVoicePlayChangedObserver")
        }
        
        if let _ = gVar.exitAlarmChangedObserver {
            NotificationCenter.default.removeObserver(gVar.exitAlarmChangedObserver!)
            gVar.exitAlarmChangedObserver = nil
            print("removeObserver: exitAlarmChangedObserver")
        }
        
        if let _ = gVar.exitAlarmVoicePlayChangedObserver {
            NotificationCenter.default.removeObserver(gVar.exitAlarmVoicePlayChangedObserver!)
            gVar.exitAlarmVoicePlayChangedObserver = nil
            print("removeObserver: exitAlarmVoicePlayChangedObserver")
        }
        
       }
    
    private func addObserver() {
        
        if gVar.changeColorObserver == nil {
            gVar.changeColorObserver = NotificationCenter.default.addObserver(
                forName: CHANGE_COLOR_NOTIFY_KEY, object: nil, queue: nil, using: changeColor)
            print("addObserver: changeColorObserver")
        }
        
        
        if gVar.autoSwitchPreferGroupChangedObserver == nil {
            gVar.autoSwitchPreferGroupChangedObserver = NotificationCenter.default.addObserver(forName: AUTO_SWITCH_PREFER_GROUP_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: autoSwitchPreferGroupChanged)
            print("addObserver: autoSwitchPreferGroupChangedObserver")
        }
        
        if gVar.enterAlarmChangedObserver == nil {
            gVar.enterAlarmChangedObserver = NotificationCenter.default.addObserver(forName: ENTER_ALARM_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: enterAlarmChanged)
            print("addObserver: enterAlarmChangedObserver")
        }
        
        if gVar.enterAlarmVoicePlayChangedObserver == nil {
            gVar.enterAlarmVoicePlayChangedObserver = NotificationCenter.default.addObserver(forName: ENTER_ALARM_VOICE_PLAY_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: enterAlarmVoicePlayChanged)
            print("addObserver: enterAlarmVoicePlayChangedObserver")
        }
        
        if gVar.exitAlarmChangedObserver == nil {
            gVar.exitAlarmChangedObserver = NotificationCenter.default.addObserver(forName: EXIT_ALARM_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: exitAlarmChanged)
            print("addObserver: exitAlarmChangedObserver")
        }
        
        if gVar.exitAlarmVoicePlayChangedObserver == nil {
            gVar.exitAlarmVoicePlayChangedObserver = NotificationCenter.default.addObserver(forName: EXIT_ALARM_VOICE_PLAY_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: exitAlarmVoicePlayChanged)
            print("addObserver: exitAlarmVoicePlayChangedObserver")
        }
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
    
    private func updatefinishButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            finishImage.image = UIImage(named: "btn_contact_pressed")
            finishImage.contentMode = .scaleToFill
            
        case .AWAY:
            finishImage.image = UIImage(named: "btn_contact_normal")
            finishImage.contentMode = .scaleToFill
        }
    }
}

// MARK: - Event Methods

extension DispEditElectrFenceViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension DispEditElectrFenceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Notification Methods

extension DispEditElectrFenceViewController {
    func changeColor(notification: Notification) -> Void {
        if let rgbColorCode = notification.userInfo?[CHANGE_COLOR_USER_KEY] as? RGBColorCode {
            // update color
            currentElectrFenceVo?.color = getUIntColor(rgbColor: rgbColorCode)
            
            colorBarButton.backgroundColor = UIColor(
                red:   CGFloat(rgbColorCode.red) / 255,
                green: CGFloat(rgbColorCode.green) / 255,
                blue:  CGFloat(rgbColorCode.blue) / 255,
                alpha: 1
            )
        }
    }
    
    func autoSwitchPreferGroupChanged(notification: Notification) -> Void {
        if let electrFenceVo = currentElectrFenceVo {
            electrFenceVo.autoSwitchPreferGroupEnabled = !(electrFenceVo.autoSwitchPreferGroupEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func enterAlarmChanged(notification: Notification) -> Void {
        if let electrFenceVo = currentElectrFenceVo {
            electrFenceVo.enterAlarmEnabled = !(electrFenceVo.enterAlarmEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func enterAlarmVoicePlayChanged(notification: Notification) -> Void {
        if let electrFenceVo = currentElectrFenceVo {
            electrFenceVo.enterAlarmVoicePlayEnabled = !(electrFenceVo.enterAlarmVoicePlayEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func exitAlarmChanged(notification: Notification) -> Void {
        if let electrFenceVo = currentElectrFenceVo {
            electrFenceVo.exitAlarmEnabled = !(electrFenceVo.exitAlarmEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func exitAlarmVoicePlayChanged(notification: Notification) -> Void {
        if let electrFenceVo = currentElectrFenceVo {
            electrFenceVo.exitAlarmVoicePlayEnabled = !(electrFenceVo.exitAlarmVoicePlayEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
}

// MARK: - Event Methods

extension DispEditElectrFenceViewController {
    @objc func showEdidColorModalDelayed() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let colorValue = currentElectrFenceVo?.color ?? 0
        
        // 將目前圍籬的顏色(EX: 0xFF0A0B)改為RGB值(EX: r:255, g:10, b:11)
        let colorCode = getRGBColor(colorValue: colorValue)
        
        appDelegate?.showEditColorModal(colorCode: colorCode)
    }
}
