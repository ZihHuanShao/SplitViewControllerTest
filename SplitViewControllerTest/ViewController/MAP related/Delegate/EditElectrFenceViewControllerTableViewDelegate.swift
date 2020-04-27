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
            enableAutoSwitchPreferGroup: true,
            preferGroup: groupVo,
            enableEnterAlarm: true,
            enablePlayEnterAlarmVoice: true,
            enterAlarmVoice: "危險區域 請儘速離開",
            enableExitAlarm: true,
            enablePlayExitAlarmVoice: true,
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 3 }
        else if section == 1 { return 3 }
        else { return 3 }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return ""
//    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0.1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testcell", for: indexPath)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = cellData.electrFenceVo?.title
            } else if indexPath.row == 1 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.enableAutoSwitchPreferGroup)
            } else {
                cell.textLabel?.text = cellData.electrFenceVo?.preferGroup?.name
            }
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.enableEnterAlarm)
            } else if indexPath.row == 1 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.enablePlayEnterAlarmVoice)
            } else {
                cell.textLabel?.text = cellData.electrFenceVo?.enterAlarmVoice
            }
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.enableExitAlarm)
            } else if indexPath.row == 1 {
                cell.textLabel?.text = String(describing: cellData.electrFenceVo?.enablePlayExitAlarmVoice)
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

    }
}
