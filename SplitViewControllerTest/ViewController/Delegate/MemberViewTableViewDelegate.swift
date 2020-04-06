//
//  MemberViewTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/31.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

class MemberViewTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    weak var viewController: MemberViewController?
    weak var tableView: UITableView?
    var profileTitles = [String]()
    
    // MARK: - initializer
    
    init(memberViewController: MemberViewController, tableView: UITableView) {
        super.init()
        self.viewController = memberViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
    }
}

// MARK: - Public Methods

extension MemberViewTableViewDelegate {
    func registerCell(cellName: String, cellId: String) {
        tableView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellId
        )
    }
    
    func setProfileTitles(_ profileTitles: [String]) {
        self.profileTitles = profileTitles
    }
    
    func reloadUI() {
        tableView?.reloadData()
    }
}

extension MemberViewTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberProfileTableViewCell", for: indexPath) as! MemberProfileTableViewCell
        cell.setProfileTitle(title: profileTitles[indexPath.row])
        cell.setProfileDesc(desc: "123")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
        
    }
}

extension MemberViewTableViewDelegate: UITableViewDelegate {
    
}
