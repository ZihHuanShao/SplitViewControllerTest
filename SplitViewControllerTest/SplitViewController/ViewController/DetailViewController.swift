//
//  DetailViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    
    var tabSelected = TabType.none
    
    // Group
    var groupNumber: Int?
    var groupName: String?
    
    // Single Member
    var memberName: String?
    var memberImageName: String?
    
    // Delegate
    fileprivate var collectionViewDelegate: DetailViewCollectionViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main menu
        collectionViewDelegate = DetailViewCollectionViewDelegate(detailViewController: self, collectionView: collectionView)
        collectionViewDelegate?.reloadUI()
        
        switch tabSelected {
        case .groups:
            let groupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GroupViewController") as! GroupViewController
            
            if let _groupName = groupName, let _groupNumber = groupNumber {
                groupVC.setGroupName(name: _groupName)
                groupVC.setGroupNumber(_groupNumber)
            }
            
            self.addChild(groupVC)
            groupVC.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
            self.containerView.addSubview(groupVC.view)
            
            groupVC.didMove(toParent: self)
        
        case .members:
            let memberVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
            
            if let _memberName = memberName {
                memberVC.setMemberName(name: _memberName)
            }
            
            if let _memberImageName = memberImageName {
                memberVC.setMemberImage(name: _memberImageName)
            }
            
            self.addChild(memberVC)
            memberVC.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
            self.containerView.addSubview(memberVC.view)
            
            memberVC.didMove(toParent: self)
        
        case .none:
            break
        }
        

        
    }
}

// MARK: - Public Methods

extension DetailViewController {
    func setTabSelected(type: TabType) {
        tabSelected = type
    }
    
    func setGroupNumber(_ number: Int) {
        groupNumber = number
    }
    
    func setGroupName(name: String) {
        groupName = name
    }
    
    func setMemberName(name: String) {
        memberName = name
    }
    
    func setMemberImageName(name: String) {
        memberImageName = name
    }
}
