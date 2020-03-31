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
            let groupsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GroupViewController") as! GroupViewController
            
            if let _groupName = groupName, let _groupNumber = groupNumber {
                groupsVC.setGroupName(name: _groupName)
                groupsVC.setGroupNumber(_groupNumber)
            }
            
            self.addChild(groupsVC)
            groupsVC.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
            self.containerView.addSubview(groupsVC.view)
            
            groupsVC.didMove(toParent: self)
        
        case .members:
            break
        
        case .none:
            break
        }
        

        
    }
}

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
}
