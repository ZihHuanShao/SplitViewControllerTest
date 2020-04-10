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
    
    // Dispatch Button View Field
    @IBOutlet weak var dispatchTitleLabel: UILabel!
    @IBOutlet weak var dispatchView: UIView!
    
    
    // MARK: - Properties

    fileprivate var tabSelected = TabType.NONE
    fileprivate var tableViewDelegate: MasterViewTableViewDelegate?
    
    // Original Test data
    
    let groupsName         = TSET_GROUPS
    let groupsDesc         = TSET_GROUPS_DESC
    let groupsCount        = TSET_GROUPS_COUNT
    let membersName        = TEST_MEMBERS
    let membersOnlineState = TEST_MEMBERS_ONLINE_STATE
    
    var groupsVo  = [GroupVo]()
    var membersVo = [MemberVo]()
    

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.preferredDisplayMode = .allVisible
        
        reloadTestData()
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
        print("dispatcherSetting pressed")
    }
    
    @IBAction func tabLeftContentButtonPressed(_ sender: UIButton) {
        tabLeftContentButtonPressedHandler()
    }
    
    @IBAction func tabRightContentButtonPressed(_ sender: UIButton) {
        tabRightContentButtonPressedHandler()
    }
    
    @IBAction func createGroupButtonPressed(_ sender: UIButton) {
        print("createGroupButtonPressed pressed")
        
        
    }
    
    @IBAction func dispatchButtonTouchDown(_ sender: UIButton) {
        print("dispatchButtonTouchDown pressed")
        
        sender.setBackgroundImage(UIImage(named: "btn_contact_pressed"), for: .normal)
    }
    
    @IBAction func dispatchButtonTouchUpInside(_ sender: UIButton) {
        print("dispatchButtonTouchUpInside pressed")
        sender.setBackgroundImage(UIImage(named: "btn_contact_normal"), for: .normal)
        
        // wait a moment before taking the screenshot
        let _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showGroupDispatchDelayed), userInfo: nil, repeats: false)
    }
    
    
    
    // MARK: - Navigation

    // Note: 使用custom cell時, prepareforsegue並不會被呼叫.
    // 因此目前做法: 定義一protocol用來觸發prepareforsegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareforsegue is called")
        if segue.identifier == "showDetail" {
            let dVC = segue.destination as? DetailViewController
            dVC?.setTabSelected(type: tabSelected)
            
            let rowIndex = tableView.indexPathForSelectedRow!.row
            
            switch tabSelected {
                
            case .GROUP:
                dVC?.updateGroup(groupsVo[rowIndex])
                
            case .MEMBER:
                dVC?.updateMember(membersVo[rowIndex])
                
            case .NONE:
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
    
    private func reloadTestData() {
        for (index, _) in groupsName.enumerated() {
            groupsVo.append(
                GroupVo(name: groupsName[index],
                        count: groupsCount[index],
                        imageName: nil,
                        desc: groupsDesc[index],
                        notifyState: true,
                        isSelected: false
                        )
            )
        }
        
        for (index, _) in membersName.enumerated() {
            membersVo.append(
                MemberVo(name: membersName[index],
                         imageName: nil,
                         onlineState: membersOnlineState[index],
                         isSelected: false)
            )
        }
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
        dispatchTitleLabel.text = "群組調度"
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
    
    private func tabLeftContentButtonPressedHandler() {
        tabSelected = .GROUP
        
        // update UI
        tabLeftIcon.image = UIImage(named: "btn_contact_group_selected")
        tabRightIcon.image = UIImage(named: "btn_contact_member_normal")
        tabLeftTitle.textColor  = UIColorFromRGB(rgbValue: UInt(TAB_SELECTED_TITLE_COLOR))
        tabRightTitle.textColor = UIColorFromRGB(rgbValue: UInt(TAB_UNSELECTED_TITLE_COLOR))
        tabBottomLeftLine.isHidden  = false
        tabBottomRightLine.isHidden = true
        dispatchView.isHidden = false
        
        // update tableView
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .GROUP)
        tableViewDelegate?.registerCell(cellName: GROUP_TABLE_VIEW_CELL, cellId: GROUP_TABLE_VIEW_CELL)
        tableViewDelegate?.updateGroups(groupsVo)
        tableViewDelegate?.reloadUI()
    }
    
    private func tabRightContentButtonPressedHandler() {
        tabSelected = .MEMBER
        
        // update UI
        tabLeftIcon.image = UIImage(named: "btn_contact_group_normal")
        tabRightIcon.image = UIImage(named: "btn_contact_member_selected")
        tabLeftTitle.textColor  = UIColorFromRGB(rgbValue: UInt(TAB_UNSELECTED_TITLE_COLOR))
        tabRightTitle.textColor = UIColorFromRGB(rgbValue: UInt(TAB_SELECTED_TITLE_COLOR))
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = false
        dispatchView.isHidden = true
        
        // update tableView
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .MEMBER)
        tableViewDelegate?.registerCell(cellName: MEMBER_TABLE_VIEW_CELL, cellId: MEMBER_TABLE_VIEW_CELL)
        tableViewDelegate?.updateMembers(membersVo)
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
    
    @objc func showGroupDispatchDelayed() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showGroupDispatch(groups: groupsName, groupsCount: groupsCount, groupsDesc: groupsDesc)
    }
}

// MARK: - UITextFieldDelegate

extension MasterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - MasterViewTableViewExtendDelegate

extension MasterViewController: MasterViewTableViewExtendDelegate {
    func activateSegue() {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}
