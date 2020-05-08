//
//  DispElectrFenceTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispElectrFenceTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    // [Section Head View]
    @IBOutlet weak var sectionHeadView: UIView!
    
    @IBOutlet weak var sectionHeadTitle: UILabel!
    @IBOutlet weak var sectionHeadButton: UIButton!
    
    // [Section Data View]
    @IBOutlet weak var sectionDataView: UIView!
    
    // Tall View
    @IBOutlet weak var sectionDataTallView: UIView!
    @IBOutlet weak var forbiddenButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    // Short View
    @IBOutlet weak var sectionDataShortView: UIView!
    @IBOutlet weak var editFenceScopeView: UIView!  // 編輯圍籬範圍
    @IBOutlet weak var editFenceScopeTitle: UILabel!
    @IBOutlet weak var borderColorView: UIView!     // 框線顏色
    @IBOutlet weak var borderColorTitle: UILabel!
    @IBOutlet weak var borderColorButton: UIButton!
    @IBOutlet weak var enterAlarmView: UIView!      // 進入警告
    @IBOutlet weak var enterAlarmTitle: UILabel!
    @IBOutlet weak var enterAlarmButton: UIButton!
    @IBOutlet weak var exitAlarmView: UIView!       // 離開警告
    @IBOutlet weak var exitAlarmTitle: UILabel!
    @IBOutlet weak var exitAlarmButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    @IBAction func sectionHeadButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func editFenceScopeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func borderColorButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func enterAlarmButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func exitAlarmButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func forbiddenButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
    }
}

// MARK: - Public Methods

extension DispElectrFenceTableViewCell {
    func updateCell(withHeadTitle title: String) {
        sectionHeadTitle.text = title
        displayMode(mode: .HEAD)
    }
    
    func updateCell(electrFenceTableMode: ElectrFenceTableMode, electrFenceVo: ElectrFenceVo?) {
        switch electrFenceTableMode {
       
        case .HEAD:
            sectionHeadTitle.text = electrFenceVo?.title
            displayMode(mode: .HEAD)
            
        case .EDIT_FENCE_SCOPE:
            editFenceScopeTitle.text = "編輯圍籬範圍"
            displayMode(mode: .EDIT_FENCE_SCOPE)
            
        case .BORDER_COLOR:
            borderColorTitle.text = "框線顏色"
            if let color = electrFenceVo?.color {
                borderColorButton.backgroundColor = UIColorFromRGB(colorValue: color)
            }
            displayMode(mode: .BORDER_COLOR)
            
        case .ENTER_ALARM:
            enterAlarmTitle.text = "進入警告"
            if let enterAlarmEnabled = electrFenceVo?.enterAlarmEnabled {
                if enterAlarmEnabled {
                    enterAlarmButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
                } else {
                    enterAlarmButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
                }
            }
            
            displayMode(mode: .ENTER_ALARM)
            
        case .EXIT_ALARM:
            exitAlarmTitle.text = "離開警告"
            if let exitAlarmEnabled = electrFenceVo?.exitAlarmEnabled {
                if exitAlarmEnabled {
                    exitAlarmButton.setImage(UIImage(named: "btn_switch_on"), for: .normal)
                } else {
                    exitAlarmButton.setImage(UIImage(named: "btn_switch_off"), for: .normal)
                }
            }
            
            displayMode(mode: .EXIT_ALARM)
            
        case .FORBIDDEN_AND_SETTING:
            forbiddenButton.setTitle("停用", for: .normal)
            settingButton.setTitle("設定", for: .normal)
            displayMode(mode: .FORBIDDEN_AND_SETTING)
        }
    }
}

// MARK: - Private Methods

extension DispElectrFenceTableViewCell {
    private func updateUI() {
        forbiddenButton.layer.cornerRadius = 5
        forbiddenButton.clipsToBounds = true
        settingButton.layer.cornerRadius = 5
        settingButton.clipsToBounds = true
    }
    
    private func UIColorFromRGB(colorValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((colorValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((colorValue & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat(colorValue  & 0x0000FF)        / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    private func displayMode(mode: ElectrFenceTableMode) {
        switch mode {
        
        // 標頭列
        case .HEAD:
            sectionHeadView.isHidden = false
            sectionDataView.isHidden = true
        
        // 編輯圍籬範圍
        case .EDIT_FENCE_SCOPE:
            sectionHeadView.isHidden = true
            sectionDataView.isHidden = false
            
            sectionDataTallView.isHidden = true
            sectionDataShortView.isHidden = false
            
            editFenceScopeView.isHidden = false
            borderColorView.isHidden = true
            enterAlarmView.isHidden = true
            exitAlarmView.isHidden = true
        
        // 框線顏色
        case .BORDER_COLOR:
            sectionHeadView.isHidden = true
            sectionDataView.isHidden = false
            
            sectionDataTallView.isHidden = true
            sectionDataShortView.isHidden = false
            
            editFenceScopeView.isHidden = true
            borderColorView.isHidden = false
            enterAlarmView.isHidden = true
            exitAlarmView.isHidden = true
        
        // 進入警告
        case .ENTER_ALARM:
            sectionHeadView.isHidden = true
            sectionDataView.isHidden = false
            
            sectionDataTallView.isHidden = true
            sectionDataShortView.isHidden = false
            
            editFenceScopeView.isHidden = true
            borderColorView.isHidden = true
            enterAlarmView.isHidden = false
            exitAlarmView.isHidden = true
            
        // 離開警告
        case .EXIT_ALARM:
            sectionHeadView.isHidden = true
            sectionDataView.isHidden = false
            
            sectionDataTallView.isHidden = true
            sectionDataShortView.isHidden = false
            
            editFenceScopeView.isHidden = true
            borderColorView.isHidden = true
            enterAlarmView.isHidden = true
            exitAlarmView.isHidden = false
        
        // 停用/設定
        case .FORBIDDEN_AND_SETTING:
            sectionHeadView.isHidden = true
            sectionDataView.isHidden = false
            
            sectionDataTallView.isHidden = false
            sectionDataShortView.isHidden = true
            
        }
    }
}
