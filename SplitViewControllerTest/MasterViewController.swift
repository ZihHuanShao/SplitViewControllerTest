//
//  MasterViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    // MARK: - IBOutlet
    
    // Title Filed
    @IBOutlet weak var dispatcherImage: UIButton!
    @IBOutlet weak var dispatcherName: UILabel!

    // Tab Filed
    @IBOutlet weak var tabLeftIcon: UIImageView!
    @IBOutlet weak var tabRightIcon: UIImageView!
    @IBOutlet weak var tabLeftTitle: UILabel!
    @IBOutlet weak var tabRightTitle: UILabel!
    @IBOutlet weak var tabBottomLeftLine: UIView!
    @IBOutlet weak var tabBottomRightLine: UIView!
    
    // Search Filed
    @IBOutlet weak var searchTextField: UITextField!
    
    // TableView Field
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    fileprivate var tableViewDelegate: MasterViewTableViewDelegate?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDataSource()
        updateUI()
        updateGesture()

        
        
    }
    
    /*
    // 點擊空白處讓鍵盤消失, 同dismissKeyBoard(), 不知有什麼差別, 暫時先使用dismissKeyBoard()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    */
    
    // MARK: - Actions
    
    @IBAction func dispatcherSetting(_ sender: UIButton) {
    }
    
    @IBAction func tabLeftContentButtonPressed(_ sender: UIButton) {
        tabLeftContentButtonPressedHandler()
    }
    
    @IBAction func tabRightContentButtonPressed(_ sender: UIButton) {
        tabRightContentButtonPressedHandler()
    }
    
    // MARK: - Navigation

    // Note: 使用custom cell時, prepareforsegue並不會被呼叫.
    // 因此目前暫時做法: 當按下某一個cell再回來call prepareforsegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareforsegue is called")
        if segue.identifier == "showDetail" {
            let dVC = segue.destination as? DetailViewController
            if let data = tableViewDelegate?.getData() {
                dVC?.str = data[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
}



// MARK: - Private Methods

extension MasterViewController {
    
    private func updateDataSource() {
        searchTextField.delegate = self
    }
    
    private func updateUI() {
        
        // Navigation Bar Field
        self.navigationController?.navigationBar.isHidden = true
        
        // Title Field
        dispatcherImage.layer.cornerRadius = dispatcherImage.frame.size.width / 2
        dispatcherImage.clipsToBounds      = true
        dispatcherImage.backgroundColor    = .lightGray
        dispatcherName.text = "調度員"
        
        // Tab Filed
        tabLeftTitle.text  = "群組"
        tabRightTitle.text = "聯絡人"
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = true
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
    
    private func tabLeftContentButtonPressedHandler() {
        
        tabBottomLeftLine.isHidden  = false
        tabBottomRightLine.isHidden = true
        
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .groups)
        tableViewDelegate?.registerCell(cellName: "GroupsTableViewCell", cellId: "GroupsTableViewCell")
        tableViewDelegate?.reloadUI()
    }
    
    private func tabRightContentButtonPressedHandler() {

        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = false
        
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .members)
        tableViewDelegate?.registerCell(cellName: "MembersTableViewCell", cellId: "MembersTableViewCell")
        tableViewDelegate?.reloadUI()
    }
    
}

// MARK: - Event Methods

extension MasterViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension MasterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
