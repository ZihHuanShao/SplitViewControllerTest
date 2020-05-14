//
//  DispAddMemberViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispAddMemberViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var cancelButtonView: UIButton!
    @IBOutlet weak var finishButtonView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // tableview
    fileprivate var tableViewDelegate: DispAddMemberViewControllerTableViewDelegate?
    
    // collectionview
    fileprivate var collectionViewDelegate: DispAddMemberViewControllerCollectionViewDelegate?
    
    // Original Test data
    fileprivate var membersVo = [MemberVo]()
    
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
        
        let selectedMembersVo = collectionViewDelegate?.getSelectedMembers()
        appDelegate?.dismissOverlayWithSelectedMembers(selectedMembersVo)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        print("resetButtonPressed")
        tableViewDelegate?.resetMembers()
        tableViewDelegate?.reloadUI()
        
        collectionViewDelegate?.resetSelectMembers()
        collectionViewDelegate?.reloadUI()
    }
}

// MARK: - UITextFieldDelegate

extension DispAddMemberViewController: UITextFieldDelegate {
    func setSearchTextFieldDataSource() {
        searchTextField.delegate = self
    }
}

// MARK: - Public Methods

extension DispAddMemberViewController {
    func updateMembersVo(_ membersVo: [MemberVo]) {
        self.membersVo = membersVo
    }
}

// MARK: - Private Methods

extension DispAddMemberViewController {
    
    private func removeObserver() {
        if let _ = gVar.Notification.dropSelectedMemberObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.dropSelectedMemberObserver!)
            gVar.Notification.dropSelectedMemberObserver = nil
            print("removeObserver: dropSelectedMemberObserver")
        }
    }
    
    private func addObserver() {
        if gVar.Notification.dropSelectedMemberObserver == nil {
            gVar.Notification.dropSelectedMemberObserver = NotificationCenter.default.addObserver(forName: DROP_SELECTED_MEMBER_TABLE_CELL_NOTIFY_KEY, object: nil, queue: nil, using: dropSelectedMember)
            print("addObserver: dropSelectedMemberObserver")
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
        
        cancelButtonView.setTitle(str_dispAddMember_cancel, for: .normal)
        finishButtonView.setTitle(str_dispAddMember_finish, for: .normal)
        
        //
        // TableView
        //
        
        tableViewDelegate = DispAddMemberViewControllerTableViewDelegate(dispAddMemberViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_ADD_MEMBER_TABLE_VIEW_CELL, cellId: DISP_ADD_MEMBER_TABLE_VIEW_CELL)
        
        tableViewDelegate?.updateMembersVo(membersVo)

        
        //
        // CollectionView
        //
        
        collectionViewDelegate = DispAddMemberViewControllerCollectionViewDelegate(dispAddMemberViewController: self, collectionView: collectionView)
        collectionViewDelegate?.registerCell(cellName: DISP_ADD_MEMBER_COLLECTION_VIEW_CELL, cellId: DISP_ADD_MEMBER_COLLECTION_VIEW_CELL)
        
        
        tableViewDelegate?.resetMembers()
        tableViewDelegate?.reloadUI()
        
        collectionViewDelegate?.resetSelectMembers()
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

extension DispAddMemberViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - Notification Methods

extension DispAddMemberViewController {
    func dropSelectedMember(notification: Notification) -> Void {
        if let rowIndex = notification.userInfo?[DROP_SELECTED_MEMBER_TABLE_CELL_USER_KEY] as? Int {
            
            tableViewDelegate?.deselectMember(rowIndex: rowIndex)
            collectionViewDelegate?.removeSelectedMember(tableRowIndex: rowIndex)
            
            tableViewDelegate?.reloadUI()
            collectionViewDelegate?.reloadUI()
        }
    }
}

// MARK: - AddMemberTableViewExtendDelegate

extension DispAddMemberViewController: AddMemberViewControllerTableViewDelegateExtend {
    func pickupMember(tableRowIndex: Int, selectedMemberVo: MemberVo) {
        collectionViewDelegate?.appendSelectedMember(tableRowIndex: tableRowIndex, selectedMemberVo)
        collectionViewDelegate?.reloadUI()
    }
}
