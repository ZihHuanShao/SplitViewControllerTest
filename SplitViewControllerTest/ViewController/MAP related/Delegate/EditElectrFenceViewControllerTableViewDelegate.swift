//
//  EditElectrFenceViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/27.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var electrFenceVo: ElectrFenceVo?
    
    init(electrFenceVo: ElectrFenceVo) {
        self.electrFenceVo = electrFenceVo
    }
}

class EditElectrFenceViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: EditElectrFenceViewController?
    fileprivate weak var tableView: UITableView?
    
    fileprivate var electrFenceVo: ElectrFenceVo?
    
    // MARK: - initializer
    
    init(editElectrFenceViewController: EditElectrFenceViewController, tableView: UITableView) {
        super.init()
        self.viewController = editElectrFenceViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}


// MARK: - Public Methods

extension EditElectrFenceViewControllerTableViewDelegate {
    
    func updateElectrFenceVo(_ electrFenceVo: ElectrFenceVo) {
        self.electrFenceVo = electrFenceVo
    }
    
    func registerCell(cellName: String, cellId: String) {
        tableView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellId
        )
    }
    
    func reloadUI() {
        tableView?.reloadData()
    }
}


// MARK: - UITableViewDataSource

extension EditElectrFenceViewControllerTableViewDelegate: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // 分為三個設定的區域 (基本設定/ 進入警告/ 離開警告)
        return ElectrFenceAllAlarmType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let alarmType = ElectrFenceAllAlarmType.allCases[section]
        
        switch alarmType {
        
        case .BASIC_ALRAM_TYPE:
            // 「自動切換優先群組」啟用
            if electrFenceVo?.autoSwitchPreferGroupEnabled == true {
                return 3
            }
            // 「自動切換優先群組」關閉
            else {
                return 2
            }
            
        case .ENTER_ALARM_TYPE:
            // 「進入警告」啟用 &&「播放警示語音」啟用
            if electrFenceVo?.enterAlarmEnabled == true && electrFenceVo?.enterAlarmVoicePlayEnabled == true {
                return 3
            }
            // 「進入警告」啟用 &&「播放警示語音」關閉
            else if electrFenceVo?.enterAlarmEnabled == true && electrFenceVo?.enterAlarmVoicePlayEnabled == false {
                return 2
            }
            // 「進入警告」關閉
            else {
                return 1
            }
            
        case .EXIT_ALARM_TYPE:
            // 「離開警告」啟用 &&「播放警示語音」啟用
            if electrFenceVo?.exitAlarmEnabled == true && electrFenceVo?.exitAlarmVoicePlayEnabled == true {
                return 3
            }
            // 「離開警告」啟用 &&「播放警示語音」關閉
            else if electrFenceVo?.exitAlarmEnabled == true && electrFenceVo?.exitAlarmVoicePlayEnabled == false {
                return 2
            }
            // 「離開警告」關閉
            else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EDIT_ELECTR_FENCE_TABLE_VIEW_CELL, for: indexPath) as! EditElectrFenceTableViewCell
        
        // section 0: 基本設定(通報對象/ 自動切換優先群組/ 優先群組)
        // section 1: 進入警告(是否啟用/ 播放警示語音/ 語音內容)
        // section 2: 離開警告(是否啟用/ 播放警示語音/ 語音內容)
        let alarmType = ElectrFenceAllAlarmType.allCases[indexPath.section]
        
        if let eFenceVo = electrFenceVo {
            switch alarmType {
            
            case .BASIC_ALRAM_TYPE:
                cell.updateCell(basicAlarmType: ElectrFenceAllAlarmType.BasicAlarmType.allCases[indexPath.row], electrFenceVo: eFenceVo)
                
            case .ENTER_ALARM_TYPE:
                cell.updateCell(enterAlarmType: ElectrFenceAllAlarmType.EnterAlarmType.allCases[indexPath.row], electrFenceVo: eFenceVo)

            case .EXIT_ALARM_TYPE:
                cell.updateCell(exitAlarmType: ElectrFenceAllAlarmType.ExitAlarmType.allCases[indexPath.row], electrFenceVo: eFenceVo)
            }
        }

        cell.setIndexPath(indexPath)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate
 
extension EditElectrFenceViewControllerTableViewDelegate: UITableViewDelegate {
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alarmType = ElectrFenceAllAlarmType.allCases[indexPath.section]
        
        switch alarmType {
            
        case .BASIC_ALRAM_TYPE:
            
            switch ElectrFenceAllAlarmType.BasicAlarmType.allCases[indexPath.row] {

            case .INTERNAL_NOTIFY_TARGET:
                break
                
            case .AUTO_SWITCH_PREFER_GROUP:
                if electrFenceVo?.autoSwitchPreferGroupEnabled == true {
                    electrFenceVo?.autoSwitchPreferGroupEnabled = false
                } else {
                    electrFenceVo?.autoSwitchPreferGroupEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
                
            case .PREFER_GROUP:
                break
            }
            
            print(ElectrFenceAllAlarmType.BasicAlarmType.allCases[indexPath.row])
            
        case .ENTER_ALARM_TYPE:
            
            switch ElectrFenceAllAlarmType.EnterAlarmType.allCases[indexPath.row] {
                
            case .ENTER_ALARM:
                if electrFenceVo?.enterAlarmEnabled == true {
                    electrFenceVo?.enterAlarmEnabled = false
                } else {
                    electrFenceVo?.enterAlarmEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
                
            case .ENTER_ALARM_VOICE_PLAY:
                if electrFenceVo?.enterAlarmVoicePlayEnabled == true {
                   electrFenceVo?.enterAlarmVoicePlayEnabled = false
                } else {
                    electrFenceVo?.enterAlarmVoicePlayEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
                
            case .ENTER_ALARM_VOICE:
                break
            }
            
            print(ElectrFenceAllAlarmType.EnterAlarmType.allCases[indexPath.row])
            
        case .EXIT_ALARM_TYPE:
            
            switch ElectrFenceAllAlarmType.ExitAlarmType.allCases[indexPath.row] {
                
            case .EXIT_ALARM:
                if electrFenceVo?.exitAlarmEnabled == true {
                    electrFenceVo?.exitAlarmEnabled = false
                } else {
                    electrFenceVo?.exitAlarmEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
                
            case .EXIT_ALARM_VOICE_PLAY:
                if electrFenceVo?.exitAlarmVoicePlayEnabled == true {
                    electrFenceVo?.exitAlarmVoicePlayEnabled = false
                } else {
                    electrFenceVo?.exitAlarmVoicePlayEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
                
            case .EXIT_ALARM_VOICE:
                break
            }
            
            print(ElectrFenceAllAlarmType.ExitAlarmType.allCases[indexPath.row])
        }
    }
    */
}
