//
//  MasterViewTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit



private class CellData {
    
}

class MasterViewTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: MasterViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate weak var tableViewExtendDelegate: MasterViewTableViewExtendDelegate?
    
    fileprivate var preGroupCell: GroupTableViewCell?
    fileprivate var groupCells = [GroupTableViewCell]()
    
    fileprivate var preMemberCell: MemberTableViewCell?
    fileprivate var memberCells = [MemberTableViewCell]()
    
    fileprivate var groups = [String]()
    fileprivate var groupsCount = [Int]()
    fileprivate var groupsDesc = [String]()
    
    fileprivate var members = [String]()
    
    fileprivate var tabType = TabType.none
    
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

}

// MARK: - Public Methods

extension MasterViewTableViewDelegate {
    
    func updateData(data: [String]) {
        switch tabType {
        case .groups:
            groups = data
            
        case .members:
            members = data
            
        case .none:
            break
        }
    }
    
    func setgroupsCount(_ numbers: [Int]) {
        switch tabType {
        case .groups:
            groupsCount = numbers
            
        case .members:
            break
            
        case .none:
            break
        }
    }
    
    func setgroupsDesc(descs: [String]) {
        switch tabType {
        case .groups:
            groupsDesc = descs
            
        case .members:
            break
            
        case .none:
            break
        }
    }
    
    func getGroupData() -> [String] {
        switch tabType {
        case .groups:
            return groups
            
        case .members:
            return members
            
        case .none:
            return []
        }
    }
    
    func getgroupsCount() -> [Int] {
        switch tabType {
        case .groups:
            return groupsCount
            
        case .members:
            return []
            
        case .none:
            return []
        }
    }
    
    func getgroupsDesc() -> [String] {
        switch tabType {
        case .groups:
            return groupsDesc
            
        case .members:
            return []
            
        case .none:
            return []
        }
    }
    
    func getMemberData() -> [String] {
        return members
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

extension MasterViewTableViewDelegate: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabType {
        case .groups:
            return groups.count
            
        case .members:
            return members.count
            
        case .none:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tabType {
        case .groups:
            let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_TABLE_VIEW_CELL, for: indexPath) as! GroupTableViewCell
            cell.setGroupName(name: groups[indexPath.row])
            cell.setGroupMemberCount(groupsCount[indexPath.row])
            cell.setGroupDesc(desc: groupsDesc[indexPath.row])
            cell.disableColor()
            cell.selectionStyle = .none
            
            groupCells.append(cell)
            
            return cell
            
        case .members:
            let cell = tableView.dequeueReusableCell(withIdentifier: MEMBER_TABLE_VIEW_CELL, for: indexPath) as! MemberTableViewCell
            cell.setUserName(name: members[indexPath.row])
            cell.setOnlineDesc(desc: "有空")
            cell.selectionStyle = .none
            cell.disableColor()
            
            memberCells.append(cell)
            
            return cell
            
        case .none:
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
        case .groups:
            if let _preGroupCell = preGroupCell {
                _preGroupCell.disableColor()
            }
            groupCells[indexPath.row].enableColor()
            preGroupCell = groupCells[indexPath.row]
            
        case .members:
            if let _preMemberCell = preMemberCell {
                _preMemberCell.disableColor()
            }
            memberCells[indexPath.row].enableColor()
            preMemberCell = memberCells[indexPath.row]
            
        case .none:
            break
        }
    }
}

// MARK: - Protocol

protocol MasterViewTableViewExtendDelegate: NSObject {
    func activateSegue()
}
