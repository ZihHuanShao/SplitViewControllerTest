//
//  dp_EditElectrFenceTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/27.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_EditElectrFenceTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var indicatorImage: UIImageView!
    @IBOutlet weak var selectedDescButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!

    // MARK: - Properties
    
    // 用來比對是哪個button被按下
    fileprivate var indexPath: IndexPath?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedDescButton.contentHorizontalAlignment = .right
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    @IBAction func switchButtonPressed(_ sender: UIButton) {
        print("switchButtonPressed")
        
        if let _indexPath = indexPath {
            
            let section  = _indexPath.section
            let rowIndex = _indexPath.row
            
            switch ElectrFenceAllAlarmType.allCases[section] {
                
            case .BASIC_ALRAM_TYPE:
                switch ElectrFenceAllAlarmType.BasicAlarmType.allCases[rowIndex] {
                    
                case .INTERNAL_NOTIFY_TARGET, .PREFER_GROUP:
                    break
                    
                case .AUTO_SWITCH_PREFER_GROUP:
                    NotificationCenter.default.post(name: AUTO_SWITCH_PREFER_GROUP_CHANGED_NOTIFY_KEY, object: self, userInfo: nil)
                }
                
            case .ENTER_ALARM_TYPE:
                switch ElectrFenceAllAlarmType.EnterAlarmType.allCases[rowIndex] {
                    
                case .ENTER_ALARM:
                    NotificationCenter.default.post(name: ENTER_ALARM_CHANGED_NOTIFY_KEY, object: self, userInfo: nil)
                    
                case .ENTER_ALARM_VOICE_PLAY:
                    NotificationCenter.default.post(name: ENTER_ALARM_VOICE_PLAY_CHANGED_NOTIFY_KEY, object: self, userInfo: nil)
                    
                case .ENTER_ALARM_VOICE:
                    break
                }
                
            case .EXIT_ALARM_TYPE:
                switch ElectrFenceAllAlarmType.ExitAlarmType.allCases[rowIndex] {
                    
                case .EXIT_ALARM:
                    NotificationCenter.default.post(name: EXIT_ALARM_CHANGED_NOTIFY_KEY, object: self, userInfo: nil)
                    
                case .EXIT_ALARM_VOICE_PLAY:
                    NotificationCenter.default.post(name: EXIT_ALARM_VOICE_PLAY_CHANGED_NOTIFY_KEY, object: self, userInfo: nil)
                    
                case .EXIT_ALARM_VOICE:
                    break
                }
            }

        }
    }
    
    @IBAction func selectedDescButtonPressed(_ sender: UIButton) {
        print("selectedDescButtonPressed")
    }
    
}

// MARK: - Public Methods

extension dp_EditElectrFenceTableViewCell {
    func setIndexPath(_ indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func updateCell(basicAlarmType: ElectrFenceAllAlarmType.BasicAlarmType, dp_electrFenceVo: dp_ElectrFenceVo) {
        switch basicAlarmType {
            
        case .INTERNAL_NOTIFY_TARGET:
            itemTitle.text = str_editElectrFence_internalNotifyTarget
            
            selectedDescButton.setTitle(dp_electrFenceVo.notifyTarget?.name, for: .normal)
            displayMode(mode: .SELECTED)
            
        case .AUTO_SWITCH_PREFER_GROUP:
            itemTitle.text = str_editElectrFence_autoSwitchPreferGroup
            if dp_electrFenceVo.autoSwitchPreferGroupEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .PREFER_GROUP:
            itemTitle.text = str_editElectrFence_preferGroup
            
            selectedDescButton.setTitle(dp_electrFenceVo.preferGroup?.name, for: .normal)
            displayMode(mode: .SELECTED)
        }
    }
    
    func updateCell(enterAlarmType: ElectrFenceAllAlarmType.EnterAlarmType, dp_electrFenceVo: dp_ElectrFenceVo) {
        switch enterAlarmType {
            
        case .ENTER_ALARM:
            itemTitle.text = str_editElectrFence_enterAlarm
            if dp_electrFenceVo.enterAlarmEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .ENTER_ALARM_VOICE_PLAY:
            itemTitle.text = str_editElectrFence_playAlarmVoice
            if dp_electrFenceVo.enterAlarmVoicePlayEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .ENTER_ALARM_VOICE:
            itemTitle.text = str_editElectrFence_alarmVoice
            selectedDescButton.setTitle(dp_electrFenceVo.enterAlarmVoice, for: .normal)
            displayMode(mode: .SELECTED)
        }
    }
    
    func updateCell(exitAlarmType: ElectrFenceAllAlarmType.ExitAlarmType, dp_electrFenceVo: dp_ElectrFenceVo) {
        switch exitAlarmType {
            
        case .EXIT_ALARM:
            itemTitle.text = str_editElectrFence_exitAlarm
            if dp_electrFenceVo.exitAlarmEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .EXIT_ALARM_VOICE_PLAY:
            itemTitle.text = str_editElectrFence_playAlarmVoice
            if dp_electrFenceVo.exitAlarmVoicePlayEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .EXIT_ALARM_VOICE:
            itemTitle.text = str_editElectrFence_alarmVoice
            selectedDescButton.setTitle(dp_electrFenceVo.exitAlarmVoice, for: .normal)
            displayMode(mode: .SELECTED)
        }
    }
}

// MARK : - Private Methods

extension dp_EditElectrFenceTableViewCell {
    private func displayMode(mode: ElectrFenceAlarmSettingMode) {
        switch mode {
        
        case .SELECTED:
            selectedDescButton.isHidden = false
            indicatorImage.isHidden = false
            switchButton.isHidden = true
            
        case .SWITCH:
            selectedDescButton.isHidden = true
            indicatorImage.isHidden = true
            switchButton.isHidden = false
        }
    }
}
