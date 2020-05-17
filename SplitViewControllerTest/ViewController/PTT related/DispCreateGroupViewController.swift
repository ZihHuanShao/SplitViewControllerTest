//
//  DispCreateGroupViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/14.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class DispCreateGroupViewController: UIViewController {

    // MARK: - IBOutlet
    
    // Finish Button Field
    @IBOutlet weak var createGroupTitleLabel: UILabel!
    @IBOutlet weak var finishImage: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    
    // Group Image Field
    @IBOutlet weak var groupImage: UIImageView!
    
    // Group Desc Field
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupDescLabel: UILabel!
    @IBOutlet weak var groupDescTextField: UITextField!
    
    // Group Members Field
    @IBOutlet weak var GroupMemberTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // CreateMember Button Field
    @IBOutlet weak var createMemberImage: UIImageView!
    @IBOutlet weak var createMemberButton: UIButton!
    
    
    // MARK: - Properties
    
    // 所有成員清單
    fileprivate var membersVo = [MemberVo]()
    
    // tableview
    fileprivate var tableViewDelegate: DispCreateGroupViewControllerTableViewDelegate?
    
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTestData()
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeObserver()
    }
    
    // MARK: - Actions
    
    //
    // finishButton
    //
    
    @IBAction func finishButtonTouchDown(_ sender: UIButton) {
        updatefinishButtonImage(type: .PRESSED)
    }
    
    @IBAction func finishButtonTouchDragExit(_ sender: UIButton) {
        updatefinishButtonImage(type: .AWAY)
    }
    
    @IBAction func finishButtonTouchUpInside(_ sender: UIButton) {
        updatefinishButtonImage(type: .AWAY)
    }
    
    //
    // editGroupImageButton
    //
    
    @IBAction func editGroupImageButtonPressed(_ sender: UIButton) {
    }

    //
    // createMemberButton
    //
    
    @IBAction func createMemberButtonTouchDown(_ sender: UIButton) {
        updateCreateMemberButtonImage(type: .PRESSED)
    }
    
    @IBAction func createMemberButtonTouchDragExit(_ sender: UIButton) {
        updateCreateMemberButtonImage(type: .AWAY)
    }
    
    @IBAction func createMemberButtonTouchUpInside(_ sender: UIButton) {
        updateCreateMemberButtonImage(type: .AWAY)
        
        if !gVar.isHoldFormSheetView {
            gVar.isHoldFormSheetView = true
            
            // wait a moment before taking the screenshot
            let _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showGroupDispatchModalDelayed), userInfo: nil, repeats: false)
        }
        
    }

}

// MARK: - Private Methods

extension DispCreateGroupViewController {
    
    private func removeObserver() {
        if let _ = gVar.Notification.selectedMembersReloadedObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.selectedMembersReloadedObserver!)
            gVar.Notification.selectedMembersReloadedObserver = nil
            print("removeObserver: selectedMembersReloadedObserver")
        }
    }
    
    private func addObserver() {
        if gVar.Notification.selectedMembersReloadedObserver == nil {
            gVar.Notification.selectedMembersReloadedObserver = NotificationCenter.default.addObserver(forName: SELECTED_MEMBERS_RELOADED_NOTIFY_KEY, object: nil, queue: nil, using: selectedMembersReloaded)
            print("addObserver: selectedMembersReloadedObserver")
        }
    }
    
    private func updateDataSource() {
        setTextFieldDataSource()
        updateGesture()
    }
    
    private func reloadTestData() {
        for member in TEST_MEMBERS {
            membersVo.append(
                MemberVo(
                    name: member.name,
                    imageName: member.imageName,
                    userId: member.userId,
                    sipId: member.sipId,
                    country: member.country,
                    email: member.email,
                    onlineState: member.onlineState,
                    isSelected: member.isSelected
                )
            )
        }
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
    
    private func updateUI() {
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.clipsToBounds      = true
        
        createGroupTitleLabel.text = str_dispCreateGroup_createGroup
        groupNameLabel.text = str_dispCreateGroup_groupName
        groupDescLabel.text = str_dispCreateGroup_groupDesc
        groupNameTextField.placeholder = str_dispCreateGroup_groupName_placeholder
        groupDescTextField.placeholder = str_dispCreateGroup_groupDesc_placeholder
        GroupMemberTitleLabel.text = str_dispCreateGroup_groupMember
        
        finishButton.setTitle(str_dispCreateGroup_finish, for: .normal)
        createMemberButton.setTitle(str_dispCreateGroup_createMember, for: .normal)
        
        //
        // TableView
        //
        
        tableViewDelegate = DispCreateGroupViewControllerTableViewDelegate(dispCreateGroupViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_CREATE_GROUP_TABLE_VIEW_CELL, cellId: DISP_CREATE_GROUP_TABLE_VIEW_CELL)
        
        tableViewDelegate?.reloadUI()
        
    }
    
    private func updatefinishButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            finishImage.image = UIImage(named: "btn_contact_pressed")
            finishImage.contentMode = .scaleToFill
            
            
        case .AWAY:
            finishImage.image = UIImage(named: "btn_contact_normal")
            finishImage.contentMode = .scaleToFill
        }
    }
    
    private func updateCreateMemberButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            createMemberImage.image = UIImage(named: "btn_contact_pressed")
            createMemberImage.contentMode = .scaleToFill
            
            
        case .AWAY:
            createMemberImage.image = UIImage(named: "btn_contact_normal")
            createMemberImage.contentMode = .scaleToFill
        }
    }
}

// MARK: - UITextFieldDelegate

extension DispCreateGroupViewController: UITextFieldDelegate {
    func setTextFieldDataSource() {
        groupNameTextField.delegate = self
        groupDescTextField.delegate = self
    }
}

// MARK: - Event Methods

extension DispCreateGroupViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func showGroupDispatchModalDelayed() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showAddMemberModal(membersVo: membersVo)
    }
}

// MARK: - Notification Methods

extension DispCreateGroupViewController {
    func selectedMembersReloaded(notification: Notification) -> Void {
        if let selectedMembersVo = notification.userInfo?[SELECTED_MEMBERS_RELOADED_USER_KEY] as? [MemberVo] {
            
            tableViewDelegate?.updateMembersVo(selectedMembersVo)
            tableViewDelegate?.reloadUI()
            
        }
        
    }
}
