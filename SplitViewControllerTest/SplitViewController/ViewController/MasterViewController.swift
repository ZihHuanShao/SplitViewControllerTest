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

    var tabSelected = TabType.none
    fileprivate var tableViewDelegate: MasterViewTableViewDelegate?
    
    // Original Test data
    let groups = ["MaxkitDemo","Test Group","Fred Group","Fred Group2","Fred Group3"]
    let members = ["Martin","Charley","Fred","Michael","MayMay"]
    let groupNumbers = [6, 13, 18, 26, 50]

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.preferredDisplayMode = .allVisible
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
    // 因此目前做法: 定義一protocol用來觸發prepareforsegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareforsegue is called")
        if segue.identifier == "showDetail" {
            let dVC = segue.destination as? DetailViewController
            dVC?.setTabSelected(type: tabSelected)
            
            switch tabSelected {
            case .groups:
                if let data = tableViewDelegate?.getData(), let groupNumbers = tableViewDelegate?.getGroupNumbers() {
                    
                    dVC?.setGroupNumber(groupNumbers[tableView.indexPathForSelectedRow!.row])
                    dVC?.setGroupName(name: data[tableView.indexPathForSelectedRow!.row])
                }
                
            case .members:
                break
                
            case .none:
                break
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
        //dispatcherName.text = ""
        
        // TabView Filed
        tabLeftTitle.text  = "群組"
        tabRightTitle.text = "聯絡人"
        tabBottomLeftLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
        tabBottomRightLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
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
        tabSelected = .groups
        
        // update UI
        tabLeftIcon.image = UIImage(named: "btn_contact_group_selected")
        tabRightIcon.image = UIImage(named: "btn_contact_member_normal")
        tabLeftTitle.textColor  = UIColorFromRGB(rgbValue: UInt(TAB_SELECTED_TITLE_COLOR))
        tabRightTitle.textColor = UIColorFromRGB(rgbValue: UInt(TAB_UNSELECTED_TITLE_COLOR))
        tabBottomLeftLine.isHidden  = false
        tabBottomRightLine.isHidden = true
        
        // update tableView
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .groups)
        tableViewDelegate?.registerCell(cellName: GROUP_TABLE_VIEW_CELL, cellId: GROUP_TABLE_VIEW_CELL)
        tableViewDelegate?.updateData(data: groups)
        tableViewDelegate?.updateGroupNumbers(groupNumbers)
        tableViewDelegate?.reloadUI()
    }
    
    private func tabRightContentButtonPressedHandler() {
        tabSelected = .members
        
        // update UI
        tabLeftIcon.image = UIImage(named: "btn_contact_group_normal")
        tabRightIcon.image = UIImage(named: "btn_contact_member_selected")
        tabLeftTitle.textColor  = UIColorFromRGB(rgbValue: UInt(TAB_UNSELECTED_TITLE_COLOR))
        tabRightTitle.textColor = UIColorFromRGB(rgbValue: UInt(TAB_SELECTED_TITLE_COLOR))
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = false
        
        // update tableView
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .members)
        tableViewDelegate?.registerCell(cellName: MEMBER_TABLE_VIEW_CELL, cellId: MEMBER_TABLE_VIEW_CELL)
        tableViewDelegate?.updateData(data: members)
        tableViewDelegate?.reloadUI()
    }
    
    private func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat(rgbValue  & 0x0000FF)        / 255.0,
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
