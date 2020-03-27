//
//  MasterViewTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

enum TableViewType: Int {
    case groups  = 0
    case members = 1
    case none    = 2
}

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
    
    var preGroupCell: GroupsTableViewCell?
    var groupCells = [GroupsTableViewCell]()
    
    var preMemberCell: MembersTableViewCell?
    var memberCells = [MembersTableViewCell]()
    
    let groups = ["MaxkitDemo","Test Group","Fred Group","Fred Group2","Fred Group3"]
    let members = ["Martin","Charley","Fred","Michael","MayMay"]
    
    var tableViewType = TableViewType.none
    
    // MARK: - initializer
    
    init(masterViewController: MasterViewController, tableView: UITableView, type: TableViewType) {
        super.init()
        self.viewController = masterViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        activateSegueDelegate = self.viewController
        tableViewType = type
    }

}

// MARK: - Public Methods

extension MasterViewTableViewDelegate {
    
    func getData() -> [String] {
        switch tableViewType {
        case .groups:
            return groups
            
        case .members:
            return members
            
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
        switch tableViewType {
        case .groups:
            return groups.count
            
        case .members:
            return members.count
            
        case .none:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableViewType {
        case .groups:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as! GroupsTableViewCell
            cell.groupName.text = groups[indexPath.row]
            cell.groupMemberCount.text = "\(indexPath.row)"
            cell.selectionStyle = .none
            cell.trailingLine.isHidden = true
            groupCells.append(cell)
            
            return cell
            
        case .members:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MembersTableViewCell", for: indexPath) as! MembersTableViewCell
            cell.userName.text = members[indexPath.row]
            cell.onlineDesc.text = "有空"
            cell.selectionStyle = .none
            cell.trailingLine.isHidden = true
            memberCells.append(cell)
            
            return cell
            
        case .none:
            return UITableViewCell.init()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension MasterViewTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activateSegueDelegate?.activate()
        
        print("didSelectRowAt: \(indexPath.row)")
        
        switch tableViewType {
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
