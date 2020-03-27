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
    
    // TitleView Filed
    @IBOutlet weak var dispatcherImage: UIButton!
    @IBOutlet weak var dispatcherName: UILabel!

    // TabView Filed
    @IBOutlet weak var tabLeftIcon: UIImageView!
    @IBOutlet weak var tabRightIcon: UIImageView!
    @IBOutlet weak var tabLeftTitle: UILabel!
    @IBOutlet weak var tabRightTitle: UILabel!
    @IBOutlet weak var tabBottomLeftLine: UIView!
    @IBOutlet weak var tabBottomRightLine: UIView!
    
    // SearchView Filed
    @IBOutlet weak var searchTextField: UITextField!
    
    // TableView Field
    @IBOutlet weak var tableView: UITableView!
    
    // CreateGroupView Field
    @IBOutlet weak var createGroupButton: UIButton!
    @IBOutlet weak var createGroupTitle: UILabel!
    
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
    
    @IBAction func createGroupButtonPressed(_ sender: UIButton) {
        print("createGroupButtonPressed")
    }
    
    
    // MARK: - Navigation

    // Note: 使用custom cell時, prepareforsegue並不會被呼叫.
    // 因此目前暫時做法: 定義一protocol用來觸發prepareforsegue
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
        
        // TitleView Field
        dispatcherImage.layer.cornerRadius = dispatcherImage.frame.size.width / 2
        dispatcherImage.clipsToBounds      = true
        dispatcherImage.backgroundColor    = .lightGray
        dispatcherName.text = "調度員"
        
        // TabView Filed
        tabLeftTitle.text  = "群組"
        tabRightTitle.text = "聯絡人"
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = true
        
        // CreateGroupView Field
        createGroupTitle.text = "建立新群組"
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
    
    private func tabLeftContentButtonPressedHandler() {
        tabLeftTitle.textColor  = UIColorFromRGB(rgbValue: 0xBD1E49)
        tabRightTitle.textColor = .darkGray
        tabBottomLeftLine.isHidden  = false
        tabBottomRightLine.isHidden = true
        
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .groups)
        tableViewDelegate?.registerCell(cellName: GROUPS_TABLE_VIEW_CELL, cellId: GROUPS_TABLE_VIEW_CELL)
        tableViewDelegate?.reloadUI()
    }
    
    private func tabRightContentButtonPressedHandler() {
        tabLeftTitle.textColor  = .darkGray
        tabRightTitle.textColor = UIColorFromRGB(rgbValue: 0xBD1E49)
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = false
        
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .members)
        tableViewDelegate?.registerCell(cellName: MEMBERS_TABLE_VIEW_CELL, cellId: MEMBERS_TABLE_VIEW_CELL)
        tableViewDelegate?.reloadUI()
    }
    
    private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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

// MARK: - MasterViewTableViewActivateSegueDelegate

extension MasterViewController: MasterViewTableViewActivateSegueDelegate {
    func activate() {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}
