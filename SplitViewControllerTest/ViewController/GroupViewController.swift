//
//  GroupViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/30.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monitorImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    // MARK: - Properties
    
    fileprivate var monitorImageName: String?
    fileprivate var groupNumber: Int?
    fileprivate var groupName: String?
    fileprivate var collectionViewDelegate: GroupCollectionoViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - Actions
    
    @IBAction func groupSettingButtonPressed(_ sender: UIButton) {
    }

}

// MARK: - Public Methods
extension GroupViewController {
    func setMonitorImageName(name: String) {
        monitorImageName = name
    }
    
    func setGroupNumber(_ number: Int) {
        groupNumber = number
    }
    
    func setGroupName(name: String) {
        groupName = name
    }
}

// MARK: - Private Methods
extension GroupViewController {
    func updateUI() {
        if let _monitorImageName = monitorImageName {
            if let image = UIImage(named: _monitorImageName) {
                monitorImage.image = image
            }
        }
        if let _groupName = groupName {
            groupNameLabel.text = _groupName
        }
        
        collectionViewDelegate = GroupCollectionoViewDelegate(groupViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: GROUP_COLLECTION_VIEW_CELL, cellId: GROUP_COLLECTION_VIEW_CELL)
        
        if let _groupNumber = groupNumber {
            collectionViewDelegate?.setGroupNumber(_groupNumber)
        }
        collectionViewDelegate?.reloadUI()
    }
    
}
