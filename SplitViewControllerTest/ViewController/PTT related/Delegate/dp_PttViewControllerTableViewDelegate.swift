//
//  dp_PttViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit



private class GroupCellData {
    var dp_groupVo: dp_GroupVo?
    
    init(_ dp_groupVo: dp_GroupVo) {
        self.dp_groupVo = dp_groupVo
    }
}

private class MemberCellData {
    var dp_memberVo: dp_MemberVo?
    
    init(_ dp_memberVo: dp_MemberVo) {
        self.dp_memberVo = dp_memberVo
    }
}

class dp_PttViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_PttViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate weak var tableViewDelegateExtend: PttViewControllerTableViewDelegateExtend?
    
    fileprivate var groupCellsData  = [GroupCellData]()
    fileprivate var memberCellsData = [MemberCellData]()
    
    fileprivate var groupsVo  = [dp_GroupVo]()
    fileprivate var membersVo = [dp_MemberVo]()
    
    fileprivate var tabType = PttContactTabType.NONE
    fileprivate var preSelectedColorIndex: Int?
    
    // MARK: - initializer
    
    init(dp_pttViewController: dp_PttViewController, tableView: UITableView, type: PttContactTabType) {
        super.init()
        self.viewController = dp_pttViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableViewDelegateExtend = self.viewController
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

extension dp_PttViewControllerTableViewDelegate {
    private func reloadCellData() {
        switch tabType {
        case .GROUP:
            groupCellsData.removeAll()
            for dp_groupVo in groupsVo {
                groupCellsData.append(GroupCellData(dp_groupVo))
            }
            break
            
        case .MEMBER:
            memberCellsData.removeAll()
            for dp_memberVo in membersVo {
                memberCellsData.append(MemberCellData(dp_memberVo))
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

extension dp_PttViewControllerTableViewDelegate {
    
    func updateGroups(_ groupsVo: [dp_GroupVo]) {
        self.groupsVo = groupsVo
    }
    
    func updateMembers(_ membersVo: [dp_MemberVo]) {
        self.membersVo = membersVo
    }
    
    
    // 觸發時機: 點擊某個group的Monitor button
    // 更新某個group資訊
    func updateGroup(_ dp_groupVo: dp_GroupVo) {
        for gVo in groupsVo {
            if (gVo.name == dp_groupVo.name) {
                gVo.count = dp_groupVo.count
                gVo.desc = dp_groupVo.desc
                gVo.imageName = dp_groupVo.imageName
                gVo.monitorState = dp_groupVo.monitorState
                gVo.isSelected = dp_groupVo.isSelected
            }
        }
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

extension dp_PttViewControllerTableViewDelegate: UITableViewDataSource {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: DP_GROUP_TABLE_VIEW_CELL, for: indexPath) as! dp_GroupTableViewCell
            
            let groupCellData = groupCellsData[indexPath.row]
            
            cell.setGroupName(name: groupCellData.dp_groupVo?.name ?? "")
            cell.setGroupMemberCount(groupCellData.dp_groupVo?.count ?? 0)
            cell.setGroupDesc(desc: groupCellData.dp_groupVo?.desc ?? "")
            cell.setGroupImage(name: groupCellData.dp_groupVo?.imageName ?? "")
//            cell.setMonitorState(groupCellData.dp_groupVo?.monitorState ?? false)
            cell.setGroupCellRowIndex(indexPath.row)
            
            if (groupCellData.dp_groupVo?.monitorState == true) {
                cell.setMonitorState(true)
                cell.enableMonitor()
            } else {
                cell.setMonitorState(false)
                cell.disableMonitor()
            }
            
            (groupCellData.dp_groupVo?.isSelected == true) ? cell.enableColor() : cell.disableColor()
       
            cell.selectionStyle = .none

            return cell
            
        case .MEMBER:
            let cell = tableView.dequeueReusableCell(withIdentifier: DP_MEMBER_TABLE_VIEW_CELL, for: indexPath) as! dp_MemberTableViewCell
            
            let memberCellData = memberCellsData[indexPath.row]
            
            cell.setUserName(name: memberCellData.dp_memberVo?.name ?? "")
            
            if let onlineState = memberCellData.dp_memberVo?.onlineState {
               switch onlineState {
                case .AVAILABLE:
                    cell.setOnlineState(type: .AVAILABLE)
                
                case .BUSY:
                    cell.setOnlineState(type: .BUSY)
                
                case .NO_DISTURB:
                    cell.setOnlineState(type: .NO_DISTURB)
                
                case .OFFLINE:
                    cell.setOnlineState(type: .OFFLINE)
                }
            }
            
            (memberCellData.dp_memberVo?.isSelected == true) ? cell.enableColor() : cell.disableColor()

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

extension dp_PttViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print("didSelectRowAt: \(indexPath.row)")
        
        switch tabType {
        case .GROUP:
            // trigger seque to display UI
            tableViewDelegateExtend?.activateSegue(tapType: .TAB_GROUP_SELECT)
            tableViewDelegateExtend?.setCurrentCellRowIndex(indexPath.row)
            setColorBar(rowIndex: indexPath.row)
            
        case .MEMBER:
            // trigger seque to display UI
            tableViewDelegateExtend?.activateSegue(tapType: .TAB_MEMBER_SELECT)
            tableViewDelegateExtend?.setCurrentCellRowIndex(indexPath.row)
            setColorBar(rowIndex: indexPath.row)
            
        case .NONE:
            break
        }
        
        preSelectedColorIndex = indexPath.row
        reloadUI()
    }
}

// MARK: - Protocol

protocol PttViewControllerTableViewDelegateExtend: NSObject {
    func activateSegue(tapType: ShowPttSegueType)
    func setCurrentCellRowIndex(_ rowIndex: Int)
}
