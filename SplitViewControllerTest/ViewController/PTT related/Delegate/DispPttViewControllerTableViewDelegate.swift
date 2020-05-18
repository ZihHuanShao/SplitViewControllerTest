//
//  DispPttViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit



private class GroupCellData {
    var isClicked: Bool?
    var groupVo: GroupVo?
    
    init(_ groupVo: GroupVo) {
        self.isClicked = false
        self.groupVo = groupVo
    }
}

private class MemberCellData {
    var isClicked: Bool?
    var memberVo: MemberVo?
    
    init(_ memberVo: MemberVo) {
        self.isClicked = false
        self.memberVo = memberVo
    }
}

class DispPttViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: DispPttViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate weak var tableViewDelegateExtend: PttViewControllerTableViewDelegateExtend?
    
    fileprivate var groupCellsData  = [GroupCellData]()
    fileprivate var memberCellsData = [MemberCellData]()
    
    fileprivate var groupsVo  = [GroupVo]()
    fileprivate var membersVo = [MemberVo]()
    
    fileprivate var tabType = PttContactTabType.NONE
    
    var didSelectedRow: Int?
    var preDidSelectedRow: Int?
    
    // MARK: - initializer
    
    init(dispPttViewController: DispPttViewController, tableView: UITableView, type: PttContactTabType) {
        super.init()
        self.viewController = dispPttViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableViewDelegateExtend = self.viewController
        tabType = type   
    }
    
}

// MARK: - Private Methods

extension DispPttViewControllerTableViewDelegate {
    private func reloadCellData() {
        switch tabType {
        case .GROUP:
            groupCellsData.removeAll()
            
            for (index, groupVo) in groupsVo.enumerated() {
                groupCellsData.append(GroupCellData(groupVo))
                
                // 位於列表的第一個群組
                if index == 0 {
                    // 第一次進來Group分頁, 還未點擊其他群組, 預設顯示第一個
                    if didSelectedRow == nil {
                        groupCellsData[index].isClicked = true
                    }
                }
            }
            
            // 前一次點擊
            if preDidSelectedRow != nil {
                groupCellsData[preDidSelectedRow!].isClicked = false
            }
            
            // 目前所點擊群組
            if didSelectedRow != nil {
                groupCellsData[didSelectedRow!].isClicked = true
            }
            
            
        case .MEMBER:
            memberCellsData.removeAll()
            
            for (index, memberVo) in membersVo.enumerated() {
                memberCellsData.append(MemberCellData(memberVo))
                
                // 位於列表的第一個群組
                if index == 0 {
                    // 第一次進來Group分頁, 還未點擊其他群組, 預設顯示第一個
                    if didSelectedRow == nil {
                        memberCellsData[index].isClicked = true
                    }
                }
            }
            
            // 前一次點擊
            if preDidSelectedRow != nil {
                memberCellsData[preDidSelectedRow!].isClicked = false
            }
            
            // 目前所點擊群組
            if didSelectedRow != nil {
                memberCellsData[didSelectedRow!].isClicked = true
            }
            
        case .NONE:
            break
        }
    }
    
    private func setColorBar(rowIndex: Int) {
        
        // 若不是第一次點擊其他的群組
        if let row = didSelectedRow {
            preDidSelectedRow = row
        }
        didSelectedRow = rowIndex
    }
}

// MARK: - Public Methods

extension DispPttViewControllerTableViewDelegate {
    
    func updateGroups(_ groupsVo: [GroupVo]) {
        self.groupsVo = groupsVo
    }
    
    func updateMembers(_ membersVo: [MemberVo]) {
        self.membersVo = membersVo
    }
    
    
    // 觸發時機: 點擊某個group的Monitor button
    // 更新某個group資訊
    func updateGroup(_ groupVo: GroupVo) {
        for gVo in groupsVo {
            if (gVo.id == groupVo.id) {
                gVo.name = groupVo.name
                gVo.count = groupVo.count
                gVo.desc = groupVo.desc
                gVo.imageName = groupVo.imageName
                gVo.monitorState = groupVo.monitorState
                gVo.isSelected = groupVo.isSelected
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

extension DispPttViewControllerTableViewDelegate: UITableViewDataSource {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: DISP_GROUP_TABLE_VIEW_CELL, for: indexPath) as! DispGroupTableViewCell
            
            let groupCellData = groupCellsData[indexPath.row]
            
            cell.setGroupName(name: groupCellData.groupVo?.name ?? "")
            cell.setGroupMemberCount(groupCellData.groupVo?.count ?? 0)
            cell.setGroupDesc(desc: groupCellData.groupVo?.desc ?? "")
            cell.setGroupImage(name: groupCellData.groupVo?.imageName ?? "")
//            cell.setMonitorState(groupCellData.groupVo?.monitorState ?? false)
            cell.setGroupCellRowIndex(indexPath.row)
            
            if (groupCellData.groupVo?.monitorState == true) {
                cell.setMonitorState(true)
                cell.enableMonitor()
            } else {
                cell.setMonitorState(false)
                cell.disableMonitor()
            }
            
            (groupCellData.isClicked == true) ? cell.enableColor() : cell.disableColor()
       
            cell.selectionStyle = .none

            return cell
            
        case .MEMBER:
            let cell = tableView.dequeueReusableCell(withIdentifier: DISP_MEMBER_TABLE_VIEW_CELL, for: indexPath) as! DispMemberTableViewCell
            
            let memberCellData = memberCellsData[indexPath.row]
            
            cell.setUserName(name: memberCellData.memberVo?.name ?? "")
            
            if let onlineState = memberCellData.memberVo?.onlineState {
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
            
            (memberCellData.isClicked == true) ? cell.enableColor() : cell.disableColor()

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

extension DispPttViewControllerTableViewDelegate: UITableViewDelegate {
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
        
        reloadUI()
    }
}

// MARK: - Protocol

protocol PttViewControllerTableViewDelegateExtend: NSObject {
    func activateSegue(tapType: ShowPttSegueType)
    func setCurrentCellRowIndex(_ rowIndex: Int)
}
