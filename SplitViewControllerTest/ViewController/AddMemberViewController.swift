//
//  AddMemberViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var cancelButtonView: UIButton!
    @IBOutlet weak var finishButtonView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // tableview
    fileprivate var tableViewDelegate: AddMemberViewTableViewDelegate?
    
    // collectionview
    fileprivate var collectionViewDelegate: AddMemberViewCollectionViewDelegate?
    
    // Original Test data
    fileprivate var membersVo = [MemberVo]()
    
    var dropSelectedMemberObserver: NSObjectProtocol?
    
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
        NotificationCenter.default.removeObserver(dropSelectedMemberObserver!)
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

    }
}

// MARK: - UITextFieldDelegate

extension AddMemberViewController: UITextFieldDelegate {
    func setSearchTextFieldDataSource() {
        searchTextField.delegate = self
    }
}

// MARK: - Public Methods

extension AddMemberViewController {
    func updateMembersVo(_ membersVo: [MemberVo]) {
        self.membersVo = membersVo
    }
}

// MARK: - Private Methods

extension AddMemberViewController {
    
    private func updateNotificationCenter() {
        dropSelectedMemberObserver = NotificationCenter.default.addObserver(forName: DROP_SELECTED_MEMBER_TABLE_CELL_NOTIFY_KEY, object: nil, queue: nil, using: dropSelectedMember)
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
        
        cancelButtonView.setTitle(str_addMember_cancel, for: .normal)
        finishButtonView.setTitle(str_addMember_finish, for: .normal)
        
        //
        // TableView
        //
        
        tableViewDelegate = AddMemberViewTableViewDelegate(addMemberViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: ADD_MEMBER_TABLE_VIEW_CELL, cellId: ADD_MEMBER_TABLE_VIEW_CELL)
        
        tableViewDelegate?.updateMembersVo(membersVo)

        
        //
        // CollectionView
        //
        
        collectionViewDelegate = AddMemberViewCollectionViewDelegate(addMemberViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: ADD_MEMBER_COLLECTION_VIEW_CELL, cellId: ADD_MEMBER_COLLECTION_VIEW_CELL)
        
        resetData()
        collectionViewDelegate?.reloadUI()
        tableViewDelegate?.reloadUI()
    }
    
    private func resetData() {
        collectionViewDelegate?.resetSelectMembers()
        tableViewDelegate?.resetMembers()
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

extension AddMemberViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - Notification Methods

extension AddMemberViewController {
    func dropSelectedMember(notification: Notification) -> Void {
        if let rowIndex = notification.userInfo?[DROP_SELECTED_Member_TABLE_CELL_USER_KEY] as? Int {
            
            tableViewDelegate?.deselectMember(rowIndex: rowIndex)
            tableViewDelegate?.reloadUI()
            
            collectionViewDelegate?.removeSelectedMember(tableRowIndex: rowIndex)
            collectionViewDelegate?.reloadUI()
        }   
    }
}

// MARK: - AddMemberTableViewExtendDelegate

extension AddMemberViewController: AddMemberTableViewExtendDelegate {
    func pickupMember(tableRowIndex: Int, selectedMemberVo: MemberVo) {
        collectionViewDelegate?.appendSelectedMember(tableRowIndex: tableRowIndex, selectedMemberVo)
        collectionViewDelegate?.reloadUI()
    }
}
