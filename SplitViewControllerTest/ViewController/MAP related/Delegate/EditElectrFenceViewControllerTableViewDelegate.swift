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
    fileprivate var cellData: CellData!
    
    // MARK: - initializer
    
    init(editElectrFenceViewController: EditElectrFenceViewController, tableView: UITableView) {
        super.init()
        self.viewController = editElectrFenceViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.tableFooterView = UIView(frame: .zero)
    }
}


// MARK: - Public Methods

extension EditElectrFenceViewControllerTableViewDelegate {
    func reloadTestData() {
        let memberVo = MemberVo(name: "調度員Fred")
        let groupVo = GroupVo(name: "緊急通報群組")
        
        let data = ElectrFenceVo(
            title: "測試圍籬1",
            color: 0x00FF00,
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
        
        cellData = CellData(electrFenceVo: data)
        
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
//        return 3
        return ElectrFenceAllAlarmType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if cellData.electrFenceVo?.autoSwitchPreferGroupEnabled == true {
                return 3
            } else {
                return 2
            }
        }
        else if section == 1 {
            if cellData.electrFenceVo?.enterAlarmEnabled == true && cellData.electrFenceVo?.enterAlarmVoicePlayEnabled == true {
                return 3
            } else if cellData.electrFenceVo?.enterAlarmEnabled == true && cellData.electrFenceVo?.enterAlarmVoicePlayEnabled == false {
                return 2
            } else {
                return 1
            }
        }
        else {
            if cellData.electrFenceVo?.exitAlarmEnabled == true && cellData.electrFenceVo?.exitAlarmVoicePlayEnabled == true {
                return 3
            } else if cellData.electrFenceVo?.exitAlarmEnabled == true && cellData.electrFenceVo?.exitAlarmVoicePlayEnabled == false {
                return 2
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = cellData.electrFenceVo?.title
            } else if indexPath.row == 1 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.autoSwitchPreferGroupEnabled)
            } else {
                cell.textLabel?.text = cellData.electrFenceVo?.preferGroup?.name
            }
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.enterAlarmEnabled)
            } else if indexPath.row == 1 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.enterAlarmVoicePlayEnabled)
            } else {
                cell.textLabel?.text = cellData.electrFenceVo?.enterAlarmVoice
            }
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.exitAlarmEnabled)
            } else if indexPath.row == 1 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.exitAlarmVoicePlayEnabled)
            } else {
                cell.textLabel?.text = cellData.electrFenceVo?.exitAlarmVoice
            }
            
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate
 
extension EditElectrFenceViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                if cellData.electrFenceVo?.autoSwitchPreferGroupEnabled == true {
                    cellData.electrFenceVo?.autoSwitchPreferGroupEnabled = false
                } else {
                    cellData.electrFenceVo?.autoSwitchPreferGroupEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
            }
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                if cellData.electrFenceVo?.enterAlarmEnabled == true {
                    cellData.electrFenceVo?.enterAlarmEnabled = false
                } else {
                    cellData.electrFenceVo?.enterAlarmEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
            }
            else if indexPath.row == 1 {
                if cellData.electrFenceVo?.enterAlarmVoicePlayEnabled == true {
                   cellData.electrFenceVo?.enterAlarmVoicePlayEnabled = false
                } else {
                    cellData.electrFenceVo?.enterAlarmVoicePlayEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
            }
            else {
            }
        }
        else {
            if indexPath.row == 0 {
                if cellData.electrFenceVo?.exitAlarmEnabled == true {
                    cellData.electrFenceVo?.exitAlarmEnabled = false
                } else {
                    cellData.electrFenceVo?.exitAlarmEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
            }
            else if indexPath.row == 1 {
                if cellData.electrFenceVo?.exitAlarmVoicePlayEnabled == true {
                   cellData.electrFenceVo?.exitAlarmVoicePlayEnabled = false
                } else {
                    cellData.electrFenceVo?.exitAlarmVoicePlayEnabled = true
                }
                let indexes = IndexSet(integer: indexPath.section)
                tableView.reloadSections(indexes, with: .automatic)
            }
            else {
            }
        }
        
    }
}
