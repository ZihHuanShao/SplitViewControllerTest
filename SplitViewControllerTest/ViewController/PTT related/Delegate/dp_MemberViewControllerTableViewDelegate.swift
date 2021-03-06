//
//  dp_MemberViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/31.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

class dp_MemberViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_MemberViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var profileTitles = [String]()
    fileprivate var dp_memberVo: dp_MemberVo?
    
    // MARK: - initializer
    
    init(dp_memberViewController: dp_MemberViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_memberViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate   = self
    }
}

// MARK: - Public Methods

extension dp_MemberViewControllerTableViewDelegate {
    func updateMemberVo(_ dp_memberVo: dp_MemberVo) {
        self.dp_memberVo = dp_memberVo
    }
    
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

extension dp_MemberViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 目前只有四個欄位(帳號/ SIP號碼/ 國家/ 電子信箱)
        return MemberProfileType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DP_MEMBER_PROFILE_TABLE_VIEW_CELL, for: indexPath) as! dp_MemberProfileTableViewCell
        
        if let _memberVo = dp_memberVo {
            cell.updateCell(MemberProfileType.allCases[indexPath.row], dp_memberVo: _memberVo)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch MemberProfileType.allCases[indexPath.row] {
        case .USER_ID:      return 60
        case .SIP_NUMBER:   return 58
        case .COUNTRY:      return 58
        case .EMAIL:        return 60
        }
        
    }
}

// MARK: - UITableViewDelegate

extension dp_MemberViewControllerTableViewDelegate: UITableViewDelegate {
    
}
