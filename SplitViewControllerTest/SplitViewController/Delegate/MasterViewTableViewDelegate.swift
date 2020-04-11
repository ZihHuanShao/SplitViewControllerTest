//
//  MasterViewTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit



private class GroupCellData {
    var groupVo: GroupVo?
    
    init(_ groupVo: GroupVo) {
        self.groupVo = groupVo
    }
}

private class MemberCellData {
    var memberVo: MemberVo?
    
    init(_ memberVo: MemberVo) {
        self.memberVo = memberVo
    }
}

class MasterViewTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: MasterViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate weak var tableViewExtendDelegate: MasterViewTableViewExtendDelegate?
    
    fileprivate var groupCellsData  = [GroupCellData]()
    fileprivate var memberCellsData = [MemberCellData]()
    
    fileprivate var groupsVo  = [GroupVo]()
    fileprivate var membersVo = [MemberVo]()
    
    fileprivate var tabType = TabType.NONE
    fileprivate var preSelectedColorIndex: Int?
    
    // MARK: - initializer
    
    init(masterViewController: MasterViewController, tableView: UITableView, type: TabType) {
        super.init()
        self.viewController = masterViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableViewExtendDelegate = self.viewController
        tabType = type
        
    }
    
    deinit {
        switch tabType {
        case .GROUP:
            if let index = preSelectedColorIndex {
                groupsVo[index].isSelected = false
            }
            
        case .MEMBER:
            if let index = preSelectedColorIndex {
                membersVo[index].isSelected = false
            }
            
        case .NONE:
            break
        }
        
    }
}

// MARK: - Private Methods

extension MasterViewTableViewDelegate {
    private func reloadCellData() {
        switch tabType {
        case .GROUP:
            groupCellsData.removeAll()
            for groupVo in groupsVo {
                groupCellsData.append(GroupCellData(groupVo))
            }
            break
            
        case .MEMBER:
            memberCellsData.removeAll()
            for memberVo in membersVo {
                memberCellsData.append(MemberCellData(memberVo))
            }
            break
            
        case .NONE:
            break
        }
    }
    
    private func setColorBar(rowIndex: Int) {
        
        switch tabType {
        case .GROUP:
            if let index = preSelectedColorIndex {
                groupsVo[index].isSelected = false
            }
            groupsVo[rowIndex].isSelected = true
            
        case .MEMBER:
            if let index = preSelectedColorIndex {
                membersVo[index].isSelected = false
            }
            membersVo[rowIndex].isSelected = true
            
        case .NONE:
            break
        }
        
    }
}

// MARK: - Public Methods

extension MasterViewTableViewDelegate {
    
    func updateGroups(_ groupsVo: [GroupVo]) {
        self.groupsVo = groupsVo
    }
    
    func updateMembers(_ membersVo: [MemberVo]) {
        self.membersVo = membersVo
    }
    
    func registerCell(cellName: String, cellId: String) {
        tableView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellId
        )
    }
    
    func reloadUI() {
        reloadCellData()
        tableView?.reloadData()
    }
}


// MARK: - UITableViewDataSource

extension MasterViewTableViewDelegate: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabType {
        case .GROUP:
            return groupCellsData.count
            
        case .MEMBER:
            return memberCellsData.count
            
        case .NONE:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tabType {
        case .GROUP:
            let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_TABLE_VIEW_CELL, for: indexPath) as! GroupTableViewCell
            
            let groupCellData = groupCellsData[indexPath.row]
            
            cell.setGroupName(name: groupCellData.groupVo?.name ?? "")
            cell.setGroupMemberCount(groupCellData.groupVo?.count ?? 0)
            cell.setGroupDesc(desc: groupCellData.groupVo?.desc ?? "")
            cell.setGroupImage(name: groupCellData.groupVo?.imageName ?? "")
            
            (groupCellData.groupVo?.notifyState == true) ?
                cell.setMonitorImage(name: "icon_group_notify_on") : cell.setMonitorImage(name: "icon_group_notify_off")
            
            (groupCellData.groupVo?.isSelected == true) ?
                cell.enableColor() : cell.disableColor()
       
            cell.selectionStyle = .none

            return cell
            
        case .MEMBER:
            let cell = tableView.dequeueReusableCell(withIdentifier: MEMBER_TABLE_VIEW_CELL, for: indexPath) as! MemberTableViewCell
            
            let memberCellData = memberCellsData[indexPath.row]
            
            cell.setUserName(name: memberCellData.memberVo?.name ?? "")
            
            
            if let onlineState = memberCellData.memberVo?.onlineState {
               switch onlineState {
                case .AVAILABLE:
                    cell.setOnlineStatusImage(name: "icon_status_online")
                    cell.setOnlineDesc(desc: "有空")
                
                case .BUSY:
                    cell.setOnlineStatusImage(name: "icon_status_busy")
                    cell.setOnlineDesc(desc: "忙碌")
                
                case .NO_DISTURB:
                    cell.setOnlineStatusImage(name: "icon_status_nodisturbing")
                    cell.setOnlineDesc(desc: "勿擾")
                
                case .OFFLINE:
                    cell.setOnlineStatusImage(name: "icon_status_offline")
                    cell.setOnlineDesc(desc: "離線")
                }
            }
            
            (memberCellData.memberVo?.isSelected == true) ? cell.enableColor() : cell.disableColor()

            cell.selectionStyle = .none
            
            return cell
            
        case .NONE:
            return UITableViewCell.init()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 固定56
        return 56
    }
}

// MARK: - UITableViewDelegate

extension MasterViewTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // trigger seque to display UI
        tableViewExtendDelegate?.activateSegue()
        
        print("didSelectRowAt: \(indexPath.row)")
        
        switch tabType {
        case .GROUP, .MEMBER:
            setColorBar(rowIndex: indexPath.row)
            
        case .NONE:
            break
        }
        
        preSelectedColorIndex = indexPath.row
        reloadUI()
    }
}

// MARK: - Protocol

protocol MasterViewTableViewExtendDelegate: NSObject {
    func activateSegue()
}
