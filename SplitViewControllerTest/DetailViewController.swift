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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    
    var str: String?
    fileprivate var collectionViewDelegate: DetailViewCollectionViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDelegate = DetailViewCollectionViewDelegate(detailViewController: self, collectionView: collectionView)
        
        if let _str = str {
            label.text = _str
        }
        
        let groupsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GroupsViewController") as! GroupsViewController
        self.addChild(groupsVC)
        groupsVC.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(groupsVC.view)
        groupsVC.didMove(toParent: self)
        
    }
    

}
