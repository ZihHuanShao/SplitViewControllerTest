//
//  EditElectrFenceTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/27.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class EditElectrFenceTableViewCell: UITableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var indicatorImage: UIImageView!
    @IBOutlet weak var selectedDescButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    
//    private var alarmType: ElectrFenceAllAlarmType!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedDescButton.contentHorizontalAlignment = .right
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func switchButtonPressed(_ sender: UIButton) {
        print("switchButtonPressed")
    }
    
    @IBAction func selectedDescButtonPressed(_ sender: UIButton) {
        print("selectedDescButtonPressed")
    }
    
}

extension EditElectrFenceTableViewCell {
    
    func updateCell(basicAlarmType: ElectrFenceAllAlarmType.BasicAlarmType, electrFenceVo: ElectrFenceVo) {
        switch basicAlarmType {
            
        case .INTERNAL_NOTIFY_TARGET:
            itemTitle.text = "內部通報對象"
            
            selectedDescButton.setTitle(electrFenceVo.notifyTarget?.name, for: .normal)
            displayMode(mode: .SELECTED)
            
        case .AUTO_SWITCH_PREFER_GROUP:
            itemTitle.text = "自動切換優先群組"
            if electrFenceVo.autoSwitchPreferGroupEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .PREFER_GROUP:
            itemTitle.text = "優先群組"
            
            selectedDescButton.setTitle(electrFenceVo.preferGroup?.name, for: .normal)
            displayMode(mode: .SELECTED)
        }
    }
    
    func updateCell(enterAlarmType: ElectrFenceAllAlarmType.EnterAlarmType, electrFenceVo: ElectrFenceVo) {
        switch enterAlarmType {
            
        case .ENTER_ALARM:
            itemTitle.text = "進入警告"
            if electrFenceVo.enterAlarmEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .ENTER_ALARM_VOICE_PLAY:
            itemTitle.text = "播放警示語音"
            if electrFenceVo.enterAlarmVoicePlayEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .ENTER_ALARM_VOICE:
            itemTitle.text = "語音內容"
            selectedDescButton.setTitle(electrFenceVo.enterAlarmVoice, for: .normal)
            displayMode(mode: .SELECTED)
        }
    }
    
    func updateCell(exitAlarmType: ElectrFenceAllAlarmType.ExitAlarmType, electrFenceVo: ElectrFenceVo) {
        switch exitAlarmType {
            
        case .EXIT_ALARM:
            itemTitle.text = "離開警告"
            if electrFenceVo.exitAlarmEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .EXIT_ALARM_VOICE_PLAY:
            itemTitle.text = "播放警示語音"
            if electrFenceVo.exitAlarmVoicePlayEnabled {
                switchButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
            } else {
                switchButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
            }
            displayMode(mode: .SWITCH)
            
        case .EXIT_ALARM_VOICE:
            itemTitle.text = "語音內容"
            selectedDescButton.setTitle(electrFenceVo.exitAlarmVoice, for: .normal)
            displayMode(mode: .SELECTED)
        }
    }
}

// MARK : - Private Methods
extension EditElectrFenceTableViewCell {
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
