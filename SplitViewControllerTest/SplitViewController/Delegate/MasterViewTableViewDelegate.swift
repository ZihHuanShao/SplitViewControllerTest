//
//  MasterViewTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol MasterViewTableViewActivateSegueDelegate: NSObject {
    func activate()
}

private class CellData {
    
}

class MasterViewTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    weak var viewController: MasterViewController?
    weak var tableView: UITableView?
    weak var activateSegueDelegate: MasterViewTableViewActivateSegueDelegate?
    
    var preGroupCell: GroupTableViewCell?
    var groupCells = [GroupTableViewCell]()
    
    var preMemberCell: MemberTableViewCell?
    var memberCells = [MemberTableViewCell]()
    
    var groups = [String]()
    var members = [String]()
    var groupNumbers = [Int]()
    
    var tabType = TabType.none
    
    // MARK: - initializer
    
    init(masterViewController: MasterViewController, tableView: UITableView, type: TabType) {
        super.init()
        self.viewController = masterViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        activateSegueDelegate = self.viewController
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
    
    func updateGroupNumbers(_ numbers: [Int]) {
        switch tabType {
        case .groups:
            self.groupNumbers = numbers
            
        case .members:
            break
            
        case .none:
            break
        }
    }
    
    func getData() -> [String] {
        switch tabType {
        case .groups:
            return groups
            
        case .members:
            return members
            
        case .none:
            return []
        }
    }
    
    func getGroupNumbers() -> [Int] {
        switch tabType {
        case .groups:
            return groupNumbers
            
        case .members:
            return []
            
        case .none:
            return []
        }
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
            cell.setGroupMemberCount(indexPath.row)
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
        activateSegueDelegate?.activate()
        
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
