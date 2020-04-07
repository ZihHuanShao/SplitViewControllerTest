//
//  MemberTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/31.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

class MemberTableViewDelegate: NSObject {
    
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

extension MemberTableViewDelegate {
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

// MARK: - UITableViewDataSource

extension MemberTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 目前只有四個欄位(帳號/ SIP號碼/ 國家/ 電子信箱)
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MEMBER_PROFILE_TABLE_VIEW_CELL, for: indexPath) as! MemberProfileTableViewCell
        cell.setProfileTitle(title: profileTitles[indexPath.row])
        cell.setProfileDesc(desc: "123")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
        
    }
}

// MARK: - UITableViewDelegate

extension MemberTableViewDelegate: UITableViewDelegate {
    
}
