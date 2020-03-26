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
    
    weak var viewController: MasterViewController?
    weak var tableView: UITableView?
    
    
    
    let appleProduct = ["", "", "", "MaxkitDemo","Test Group","Fred Group","Fred Group2","Fred Group3"]
    
    init(masterViewController: MasterViewController, tableView: UITableView) {
        super.init()
        self.viewController = masterViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getData() -> [String] {
        return appleProduct
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

extension MasterViewTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleInfoTableViewCell", for: indexPath) as! TitleInfoTableViewCell
            
            cell.userName?.text = "調度員"
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTabTableViewCell", for: indexPath) as! TitleTabTableViewCell
            
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupMembersTableViewCell", for: indexPath) as! GroupMembersTableViewCell
            cell.groupName.text = appleProduct[indexPath.row]
            cell.groupMemberCount.text = "\(indexPath.row)"
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 64
            
        default:
            return 56
        }
        

    }
}

extension MasterViewTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reloadUI()
        print(indexPath.row)
       
    }
}
