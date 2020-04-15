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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    // MARK: - Actions
    
    //
    // chatButton
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


}

// MARK: - Private Methods

extension CreateGroupViewController {
    private func updateUI() {
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        groupImage.clipsToBounds      = true
        
        finishButton.setTitle(str_createGroup_finish, for: .normal)
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
}
