//
//  CreateGroupViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/14.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {

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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
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
    }

}

// MARK: - Private Methods

extension CreateGroupViewController {
    private func updateUI() {
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.clipsToBounds      = true
        
        createGroupTitleLabel.text = str_createGroup_createGroup
        groupNameLabel.text = str_createGroup_groupName
        groupDescLabel.text = str_createGroup_groupDesc
        groupNameTextField.placeholder = str_createGroup_groupName_placeholder
        groupDescTextField.placeholder = str_createGroup_groupDesc_placeholder
        GroupMemberTitleLabel.text = str_createGroup_groupMember
        
        finishButton.setTitle(str_createGroup_finish, for: .normal)
        createMemberButton.setTitle(str_createGroup_createMember, for: .normal)
    }
    
    private func updatefinishButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            finishImage.image = UIImage(named: "btn_contact_pressed")
            finishImage.contentMode = .scaleAspectFill
            
            
        case .AWAY:
            finishImage.image = UIImage(named: "btn_contact_normal")
            finishImage.contentMode = .scaleAspectFill
        }
    }
    
    private func updateCreateMemberButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            createMemberImage.image = UIImage(named: "btn_contact_pressed")
            createMemberImage.contentMode = .scaleAspectFill
            
            
        case .AWAY:
            createMemberImage.image = UIImage(named: "btn_contact_normal")
            createMemberImage.contentMode = .scaleAspectFill
        }
    }
}
