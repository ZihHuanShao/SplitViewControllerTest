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
    
    weak var viewController: MasterViewController?
    weak var tableView: UITableView?

    var preCell: GroupsTableViewCell?
    var cells = [GroupsTableViewCell]()
    let appleProduct = ["MaxkitDemo","Test Group","Fred Group","Fred Group2","Fred Group3"]
    
    // MARK: - initializer
    
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

// MARK: - UITableViewDataSource

extension MasterViewTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableViewCell", for: indexPath) as! GroupsTableViewCell
        cell.groupName.text = appleProduct[indexPath.row]
        cell.groupMemberCount.text = "\(indexPath.row)"
        cell.selectionStyle = .none
    
        cells.append(cell)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension MasterViewTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _preCell = preCell {
            _preCell.disableColor()
        }
        print("didSelectRowAt: \(indexPath.row)")
        cells[indexPath.row].enableColor()
        preCell = cells[indexPath.row]
        
        // W/A for segue
        viewController?.performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
