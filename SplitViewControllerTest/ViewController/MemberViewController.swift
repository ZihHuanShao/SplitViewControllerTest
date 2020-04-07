//
//  MemberViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/31.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MemberViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    
    // tableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var memberImageName: String?
    var memberName: String?
    let profileTitles = ["帳號", "SIP號碼", "國家", "電子信箱"]
    
    // tableview
    fileprivate var tableViewDelegate: MemberTableViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Public Methods

extension MemberViewController {
    func updateUI() {
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds      = true
        
        if let _memberImageName = memberImageName {
            if let image = UIImage(named: _memberImageName) {
                memberImage.image = image
            }
        }
        
        if let _memberName = memberName {
            memberNameLabel.text = _memberName
        }
        
        tableViewDelegate = MemberTableViewDelegate(memberViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: MEMBER_PROFILE_TABLE_VIEW_CELL, cellId: MEMBER_PROFILE_TABLE_VIEW_CELL)
        tableViewDelegate?.setProfileTitles(profileTitles)
        tableViewDelegate?.reloadUI()
    }
    
    func setMemberImage(name: String) {
        memberImageName = name
    }
    
    func setMemberName(name: String) {
        memberName = name
    }
}
