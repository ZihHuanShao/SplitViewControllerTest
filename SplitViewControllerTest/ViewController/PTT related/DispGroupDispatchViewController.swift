//
//  DispGroupDispatchViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispGroupDispatchViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var cancelButtonView: UIButton!
    @IBOutlet weak var finishButtonView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // tableview
    fileprivate var tableViewDelegate: DispGroupDispatchViewControllerTableViewDelegate?
    
    // collectionview
    fileprivate var collectionViewDelegate: DispGroupDispatchViewControllerCollectionViewDelegate?
    
    // Original Test data
    fileprivate var groupsVo = [GroupVo]()
    
    
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

extension DispGroupDispatchViewController: UITextFieldDelegate {
    func setSearchTextFieldDataSource() {
        searchTextField.delegate = self
    }
}



// MARK: - Public Methods

extension DispGroupDispatchViewController {
    func updateGroupsVo(_ groupsVo: [GroupVo]) {
        self.groupsVo = groupsVo
    }
}

// MARK: - Private Methods

extension DispGroupDispatchViewController {
    
    private func removeObserver() {
        if let _ = gVar.Notification.dropSelectedGroupObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.dropSelectedGroupObserver!)
            gVar.Notification.dropSelectedGroupObserver = nil
            print("removeObserver: dropSelectedGroupObserver")
        }
    }
    
    private func addObserver() {
        if gVar.Notification.dropSelectedGroupObserver == nil {
            gVar.Notification.dropSelectedGroupObserver = NotificationCenter.default.addObserver(forName: DROP_SELECTED_GROUP_TABLE_CELL_NOTIFY_KEY, object: nil, queue: nil, using: dropSelectedGroup)
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
        
        cancelButtonView.setTitle(str_dispGroupDispatch_cancel, for: .normal)
        finishButtonView.setTitle(str_dispGroupDispatch_finish, for: .normal)
        
        // [TableView]
        
        tableViewDelegate = DispGroupDispatchViewControllerTableViewDelegate(dispGroupDispatchViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_GROUP_DISPATCH_TABLE_VIEW_CELL, cellId: DISP_GROUP_DISPATCH_TABLE_VIEW_CELL)
        tableViewDelegate?.updateGroupsVo(groupsVo)
        
        // [CollectionView]
        
        collectionViewDelegate = DispGroupDispatchViewControllerCollectionViewDelegate(dispGroupDispatchViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: DISP_GROUP_DISPATCH_COLLECTION_VIEW_CELL, cellId: DISP_GROUP_DISPATCH_COLLECTION_VIEW_CELL)
        
        
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

extension DispGroupDispatchViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - Notification Methods

extension DispGroupDispatchViewController {
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

extension DispGroupDispatchViewController: GroupDispatchViewControllerTableViewDelegateExtend {
    func pickupGroup(tableRowIndex: Int, selectedGroupVo: GroupVo) {
        collectionViewDelegate?.appendSelectedGroup(tableRowIndex: tableRowIndex, selectedGroupVo)
        collectionViewDelegate?.reloadUI()
    }
}
