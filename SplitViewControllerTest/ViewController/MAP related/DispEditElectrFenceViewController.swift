//
//  DispEditElectrFenceViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/27.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

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
    var testElectrFenceVo: ElectrFenceVo?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadElectrFenceTestData()
        updateDataSource()
        addObserver()
        updateUI()
        updateGesture()
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

// MARK: - Private Methods

extension DispEditElectrFenceViewController {
    private func updateDataSource() {
        tableViewDelegate = DispEditElectrFenceViewControllerTableViewDelegate(dispEditElectrFenceViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_EDIT_ELECTR_FENCE_TABLE_VIEW_CELL, cellId: DISP_EDIT_ELECTR_FENCE_TABLE_VIEW_CELL)
        
        if let electrFenceVo = testElectrFenceVo {
            tableViewDelegate?.updateElectrFenceVo(electrFenceVo)
        }
        
        nameTextField.delegate = self
    }
    private func reloadElectrFenceTestData() {
        let memberVo = MemberVo(name: "調度員Fred")
        let groupVo = GroupVo(name: "緊急通報群組")
        
        testElectrFenceVo = ElectrFenceVo(
            title: "測試圍籬1",
            color: 0xEE55AA,
            notifyTarget: memberVo,
            autoSwitchPreferGroupEnabled: true,
            preferGroup: groupVo,
            enterAlarmEnabled: true,
            enterAlarmVoicePlayEnabled: true,
            enterAlarmVoice: "危險區域 請儘速離開",
            exitAlarmEnabled: true,
            exitAlarmVoicePlayEnabled: true,
            exitAlarmVoice: "您已離開 測試圍籬1"
        )
    }
    
    private func updateUI() {
        nameLabel.text = str_dispEditElectrFence_name
        colorLabel.text = str_dispEditElectrFence_colorName
        customElectrFenceTitle.text = str_dispEditElectrFence_customFenceNamePrefix + "圍籬1"
        finishButton.setTitle(str_dispEditElectrFence_finish, for: .normal)
        
        colorBarBackgroundView.layer.cornerRadius = 5
        colorBarBackgroundView.clipsToBounds = true
        colorBarButton.layer.cornerRadius = 5
        colorBarButton.clipsToBounds = true
        colorBarButton.backgroundColor = UIColorFromRGB(colorValue: testElectrFenceVo?.color ?? 0x000000)
        
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
            gVar.changeColorObserver = NotificationCenter.default.addObserver(forName: CHANGE_COLOR_NOTIFY_KEY, object: nil, queue: nil, using: changeColor)
            print("addObserver: changeColorObserver")
        }
        
        
        if gVar.autoSwitchPreferGroupChangedObserver == nil {
            gVar.autoSwitchPreferGroupChangedObserver = NotificationCenter.default.addObserver(forName: AUTO_SWITCH_PREFER_GROUP_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: autoSwitchPreferGroupChanged)
            print("addObserver: switchChangedObserver")
        }
        
        if gVar.enterAlarmChangedObserver == nil {
            gVar.enterAlarmChangedObserver = NotificationCenter.default.addObserver(forName: ENTER_ALARM_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: enterAlarmChanged)
            print("addObserver: switchChangedObserver")
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
            testElectrFenceVo?.color = getUIntColor(rgbColor: rgbColorCode)
            
            colorBarButton.backgroundColor = UIColor(
                red:   CGFloat(rgbColorCode.red) / 255,
                green: CGFloat(rgbColorCode.green) / 255,
                blue:  CGFloat(rgbColorCode.blue) / 255,
                alpha: 1
            )
        }
    }
    
    func autoSwitchPreferGroupChanged(notification: Notification) -> Void {
        if let electrFenceVo = testElectrFenceVo {
            electrFenceVo.autoSwitchPreferGroupEnabled = !(electrFenceVo.autoSwitchPreferGroupEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func enterAlarmChanged(notification: Notification) -> Void {
        if let electrFenceVo = testElectrFenceVo {
            electrFenceVo.enterAlarmEnabled = !(electrFenceVo.enterAlarmEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func enterAlarmVoicePlayChanged(notification: Notification) -> Void {
        if let electrFenceVo = testElectrFenceVo {
            electrFenceVo.enterAlarmVoicePlayEnabled = !(electrFenceVo.enterAlarmVoicePlayEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func exitAlarmChanged(notification: Notification) -> Void {
        if let electrFenceVo = testElectrFenceVo {
            electrFenceVo.exitAlarmEnabled = !(electrFenceVo.exitAlarmEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
    
    func exitAlarmVoicePlayChanged(notification: Notification) -> Void {
        if let electrFenceVo = testElectrFenceVo {
            electrFenceVo.exitAlarmVoicePlayEnabled = !(electrFenceVo.exitAlarmVoicePlayEnabled)
            tableViewDelegate?.reloadUI()
        }
    }
}

// MARK: - Event Methods

extension DispEditElectrFenceViewController {
    @objc func showEdidColorModalDelayed() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let colorValue = testElectrFenceVo?.color ?? 0
        
        // 將目前圍籬的顏色(EX: 0xFF0A0B)改為RGB值(EX: r:255, g:10, b:11)
        let colorCode = getRGBColor(colorValue: colorValue)
        
        appDelegate?.showEditColorModal(colorCode: colorCode)
    }
}