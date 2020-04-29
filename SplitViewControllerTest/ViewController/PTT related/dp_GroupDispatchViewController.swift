//
//  dp_GroupDispatchViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_GroupDispatchViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var cancelButtonView: UIButton!
    @IBOutlet weak var finishButtonView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // tableview
    fileprivate var tableViewDelegate: dp_GroupDispatchViewControllerTableViewDelegate?
    
    // collectionview
    fileprivate var collectionViewDelegate: dp_GroupDispatchViewControllerCollectionViewDelegate?
    
    // Original Test data
    fileprivate var groupsVo = [dp_GroupVo]()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDataSource()
        updateGesture()
        addObserver()
        updateUI()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateSelfViewSize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        removeObserver()
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

extension dp_GroupDispatchViewController: UITextFieldDelegate {
    func setSearchTextFieldDataSource() {
        searchTextField.delegate = self
    }
}



// MARK: - Public Methods

extension dp_GroupDispatchViewController {
    func updateGroupsVo(_ groupsVo: [dp_GroupVo]) {
        self.groupsVo = groupsVo
    }
}

// MARK: - Private Methods

extension dp_GroupDispatchViewController {
    
    private func removeObserver() {
        if let _ = gVar.dropSelectedGroupObserver {
            NotificationCenter.default.removeObserver(gVar.dropSelectedGroupObserver!)
            gVar.dropSelectedGroupObserver = nil
            print("removeObserver: dropSelectedGroupObserver")
        }
    }
    
    private func addObserver() {
        if gVar.dropSelectedGroupObserver == nil {
            gVar.dropSelectedGroupObserver = NotificationCenter.default.addObserver(forName: DROP_SELECTED_GROUP_TABLE_CELL_NOTIFY_KEY, object: nil, queue: nil, using: dropSelectedGroup)
            print("addObserver: dropSelectedGroupObserver")
        }
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
//        print("width = \(CGFloat(fullWidth * 0.5)), height = \(CGFloat(fullHeight * 0.75))")
    }
    
    private func updateUI() {
        
        cancelButtonView.setTitle(str_groupDispatch_cancel, for: .normal)
        finishButtonView.setTitle(str_groupDispatch_finish, for: .normal)
        
        //
        // TableView
        //
        
        tableViewDelegate = dp_GroupDispatchViewControllerTableViewDelegate(dp_groupDispatchViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DP_GROUP_DISPATCH_TABLE_VIEW_CELL, cellId: DP_GROUP_DISPATCH_TABLE_VIEW_CELL)
        tableViewDelegate?.updateGroupsVo(groupsVo)
        
        //
        // CollectionView
        //
        
        collectionViewDelegate = dp_GroupDispatchViewControllerCollectionViewDelegate(dp_groupDispatchViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: DP_GROUP_DISPATCH_COLLECTION_VIEW_CELL, cellId: DP_GROUP_DISPATCH_COLLECTION_VIEW_CELL)
        
        
        tableViewDelegate?.resetGroups()
        tableViewDelegate?.reloadUI()
        
        collectionViewDelegate?.reloadUI()
        collectionViewDelegate?.resetSelectGroups()
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

extension dp_GroupDispatchViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - Notification Methods

extension dp_GroupDispatchViewController {
    func dropSelectedGroup(notification: Notification) -> Void {
        if let rowIndex = notification.userInfo?[DROP_SELECTED_GROUP_TABLE_CELL_USER_KEY] as? Int {
            
            tableViewDelegate?.deselectGroup(rowIndex: rowIndex)
            tableViewDelegate?.reloadUI()
            
            collectionViewDelegate?.removeSelectedGroup(tableRowIndex: rowIndex)
            collectionViewDelegate?.reloadUI()
        }
        
    }
}


// MARK: - GroupDispatchTableViewExtendDelegate

extension dp_GroupDispatchViewController: GroupDispatchViewControllerTableViewDelegateExtend {
    func pickupGroup(tableRowIndex: Int, dp_selectedGroupVo: dp_GroupVo) {
        collectionViewDelegate?.appendSelectedGroup(tableRowIndex: tableRowIndex, dp_selectedGroupVo)
        collectionViewDelegate?.reloadUI()
    }
}
