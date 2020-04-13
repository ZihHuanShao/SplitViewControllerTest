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
    
    fileprivate var groupVo: GroupVo?
    
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
    func updateGroupVo(_ groupVo: GroupVo) {
        self.groupVo = groupVo
    }
}

// MARK: - Private Methods
extension GroupViewController {
    private func updateUI() {
        
        guard let gVo = groupVo else {
            return
        }
        
        groupNameLabel.text = gVo.name
        (gVo.notifyState == true) ? enableMonitor() : disableMonitor()
        

        collectionViewDelegate = GroupCollectionoViewDelegate(groupViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: GROUP_COLLECTION_VIEW_CELL, cellId: GROUP_COLLECTION_VIEW_CELL)
        collectionViewDelegate?.setGroupNumber(gVo.count ?? 0)
        
        collectionViewDelegate?.reloadUI()
    }
    
    private func enableMonitor() {
        monitorImage.image = UIImage(named: "icon_titile_notify_on")
    }
    
    private func disableMonitor() {
        monitorImage.image = UIImage(named: "icon_titile_notify_off")
    }
}
