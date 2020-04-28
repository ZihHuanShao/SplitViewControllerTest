//
//  EditElectrFenceViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/27.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class EditElectrFenceViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var customElectrFenceTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var finishImage: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var colorBarBackgroundView: UIView!
    @IBOutlet weak var colorBarButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    var tableViewDelegate: EditElectrFenceViewControllerTableViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDataSource()
        updateUI()
        updateGesture()
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
    
    @IBAction func colorBarButtonPressed(_ sender: UIButton) {
        print("colorBarButtonPressed")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Private Methods

extension EditElectrFenceViewController {
    private func updateDataSource() {
        tableViewDelegate = EditElectrFenceViewControllerTableViewDelegate(editElectrFenceViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: EDIT_ELECTR_FENCE_TABLE_VIEW_CELL, cellId: EDIT_ELECTR_FENCE_TABLE_VIEW_CELL)
        tableViewDelegate?.updateElectrFenceVo(getElectrFenceTestData())
        
        nameTextField.delegate = self
    }
    private func getElectrFenceTestData() -> ElectrFenceVo {
        let memberVo = MemberVo(name: "調度員Fred")
        let groupVo = GroupVo(name: "緊急通報群組")
        
        return ElectrFenceVo(
            title: "測試圍籬1",
            color: 0x00FF00,
            notifyTarget: memberVo,
            autoSwitchPreferGroupEnabled: true,
            preferGroup: groupVo,
            enterAlarmEnabled: true,
            enterAlarmVoicePlayEnabled: true,
            enterAlarmVoice: "危險區域 請儘速離開",
            exitAlarmEnabled: true,
            exitAlarmVoicePlayEnabled: true,
            exitAlarmVoice: "您已離開 測試圍籬1"
        )
    }
    
    private func updateUI() {
        nameLabel.text = str_editElectrFence_name
        colorLabel.text = str_editElectrFence_colorName
        customElectrFenceTitle.text = str_editElectrFence_customFenceNamePrefix + "圍籬1"
        finishButton.setTitle(str_editElectrFence_finish, for: .normal)
        
        colorBarBackgroundView.layer.cornerRadius = 5
        colorBarBackgroundView.clipsToBounds = true
        colorBarButton.layer.cornerRadius = 5
        colorBarButton.clipsToBounds = true
        
        tableViewDelegate?.reloadUI()
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
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
}

// MARK: - Event Methods

extension EditElectrFenceViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension EditElectrFenceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
