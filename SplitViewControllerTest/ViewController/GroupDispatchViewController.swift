//
//  GroupDispatchViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class GroupDispatchViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var cancelButtonView: UIButton!
    @IBOutlet weak var finishButtonView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    
    // tableview
    fileprivate var tableViewDelegate: GroupDispatchTableViewDelegate?
    
    // collectionview
    fileprivate var collectionViewDelegate: GroupDispatchCollectionViewDelegate?
    
    // Original Test data
    fileprivate var groups = [String]()
    fileprivate var groupsDesc = [String]()
    fileprivate var groupsCount = [Int]()
    
    var dropSelectedGroupObserver: NSObjectProtocol?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDataSource()
        updateGesture()
        updateNotificationCenter()
        updateUI()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateSelfViewSize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
//        NotificationCenter.default.removeObserver(dropSelectedGroupObserver)
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissOverlay()
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissOverlay()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        print("resetButtonPressed")
        collectionViewDelegate?.resetSelectGroups()
        collectionViewDelegate?.reloadUI()
        
        tableViewDelegate?.resetGroups()
        tableViewDelegate?.reloadUI()
    }
    
}

// MARK: - UITextFieldDelegate

extension GroupDispatchViewController: UITextFieldDelegate {
    func setSearchTextFieldDataSource() {
        searchTextField.delegate = self
    }
}



// MARK: - Public Methods

extension GroupDispatchViewController {
    func setGroupsData(data: [String]) {
        groups = data
    }
    
    func setgroupsDesc(descs: [String]) {
        groupsDesc = descs
    }
    
    func setgroupsCount(numbers: [Int]) {
        groupsCount = numbers
    }
}

// MARK: - Private Methods

extension GroupDispatchViewController {
    
    private func updateNotificationCenter() {
        dropSelectedGroupObserver = NotificationCenter.default.addObserver(forName: DROP_SELECTED_GROUP_NOTIFY_KEY, object: nil, queue: nil, using: dropSelectedGroup)
    }
    
    private func updateSelfViewSize() {
        //
        // 整體外觀
        //

        let width1 = UserDefaults.standard.float(forKey: SPLIT_MASTER_VIEW_CONTROLLER_WIDTH)
        let width2 = UserDefaults.standard.float(forKey: SPLIT_DETAIL_VIEW_CONTROLLER_WIDTH)
        let fullHeight = UserDefaults.standard.float(forKey: SPLIT_VIEW_CONTROLLER_HEIGHT)
        let fullWidth  = width1 + width2
        
        // 讓寬度固定為整個畫面寬度的1/2, 高度固定為整個畫面高度的3/4
        preferredContentSize = CGSize(width: CGFloat(fullWidth * 0.5), height: CGFloat(fullHeight * 0.75))
        print("width = \(CGFloat(fullWidth * 0.5)), height = \(CGFloat(fullHeight * 0.75))")
    }
    
    private func updateUI() {
        
        cancelButtonView.setTitle("取消", for: .normal)
        finishButtonView.setTitle("完成", for: .normal)
        
        //
        // TableView
        //
        
        tableViewDelegate = GroupDispatchTableViewDelegate(groupDispatchViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: GROUP_DISPATCH_TABLE_VIEW_CELL, cellId: GROUP_DISPATCH_TABLE_VIEW_CELL)
        tableViewDelegate?.setGroups(data: groups)
        tableViewDelegate?.setgroupsDesc(descs: groupsDesc)
        tableViewDelegate?.setgroupsCount(numbers: groupsCount)
        tableViewDelegate?.reloadUI()
        
        //
        // CollectionView
        //
        
        collectionViewDelegate = GroupDispatchCollectionViewDelegate(groupDispatchViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: GROUP_DISPATCH_COLLECTION_VIEW_CELL, cellId: GROUP_DISPATCH_COLLECTION_VIEW_CELL)
        
        collectionViewDelegate?.reloadUI()
    }
    
    private func updateDataSource() {
        setSearchTextFieldDataSource()
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
}

// MARK: - Event Methods

extension GroupDispatchViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - Notification Methods

extension GroupDispatchViewController {
    func dropSelectedGroup(notification: Notification) -> Void {
        if let rowIndex = notification.userInfo?[DROP_SELECTED_GROUP_USER_KEY] as? Int {
            
            tableViewDelegate?.deselectGroup(rowIndex: rowIndex)
            tableViewDelegate?.reloadUI()
            
            collectionViewDelegate?.removeSelectedGroup(rowIndex: rowIndex)
            collectionViewDelegate?.reloadUI()
        }
        
    }
}


// MARK: - GroupDispatchTableViewExtendDelegate

extension GroupDispatchViewController: GroupDispatchTableViewExtendDelegate {
    func pickupGroup(rowIndex: Int, name: String) {
     
        collectionViewDelegate?.appendSelectedGroup(rowIndex: rowIndex, name: name)
        collectionViewDelegate?.reloadUI()
    }
}
