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
    
    fileprivate var memberVo: MemberVo?
    
    // tableview
    fileprivate var tableViewDelegate: MemberViewTableViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

}

// MARK: - Public Methods

extension MemberViewController {
    func updateMemberVo(_ memberVo: MemberVo) {
        self.memberVo = memberVo
    }
    
    func updateUI() {
        memberImage.layer.cornerRadius = memberImage.frame.size.width / 2
        memberImage.clipsToBounds      = true
        
        guard let mVo = memberVo else {
            return
        }
        
        memberNameLabel.text = mVo.name
        memberImage.image = UIImage(named: mVo.imageName ?? "")
        
        tableViewDelegate = MemberViewTableViewDelegate(memberViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: MEMBER_PROFILE_TABLE_VIEW_CELL, cellId: MEMBER_PROFILE_TABLE_VIEW_CELL)
        if let _memberVo = memberVo {
            tableViewDelegate?.updateMemberVo(_memberVo)
        }
        
        tableViewDelegate?.reloadUI()
    }
}
