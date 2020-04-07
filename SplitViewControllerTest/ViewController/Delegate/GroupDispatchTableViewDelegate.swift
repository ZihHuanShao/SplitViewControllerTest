//
//  GroupDispatchTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class GroupDispatchTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    weak var viewController: GroupDispatchViewController?
    weak var tableView: UITableView?
    var groups = [String]()
    var members = [String]()
    var groupNumbers = [Int]()
    
    // MARK: - initializer
    
    init(groupDispatchViewController: GroupDispatchViewController, tableView: UITableView) {
        super.init()
        self.viewController = groupDispatchViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
    }
    
}

// MARK: - Public Methods

extension GroupDispatchTableViewDelegate {
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

extension GroupDispatchTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_DISPATCH_TABLE_VIEW_CELL, for: indexPath) as! GroupDispatchTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension GroupDispatchTableViewDelegate: UITableViewDelegate {
    
}
