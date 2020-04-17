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
    @IBOutlet weak var createGroupoView: UIView!
    @IBOutlet weak var createGroupWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var createGroupTrailingConstraint: NSLayoutConstraint!
    
    // TableView Field
    @IBOutlet weak var tableView: UITableView!
    
    // Group Dispatch Field
    @IBOutlet weak var groupDispatchTitleLabel: UILabel!
    @IBOutlet weak var groupDispatchView: UIView!
    @IBOutlet weak var groupDispatchImage: UIImageView!
    
    
    // MARK: - Properties
    
    fileprivate var tapType = ShowDetailViewControllerType.NONE
    fileprivate var tabSelected = TabType.NONE
    fileprivate var tableViewDelegate: MasterViewTableViewDelegate?
    
    // Original Test data

    fileprivate var groupsVo  = [GroupVo]()
    fileprivate var membersVo = [MemberVo]()

    // 目前tableview列表所點擊的cell的row index
    var currentTableCellRowIndex: Int?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitViewController?.preferredDisplayMode = .allVisible
        
        
        reloadTestData()
        updateDataSource()
        updateUI()
        updateGesture()
        addObserver()
        
        // 預設顯示「群組」列表
        tabLeftContentButtonPressed(UIButton())
        tableViewDelegate?.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(changeMonitorObserver!)
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
    
    //
    // tabLeftContentButton
    //
    
    @IBAction func tabLeftContentButtonPressed(_ sender: UIButton) {
        tabLeftContentButtonPressedHandler()
    }
    
    @IBAction func tabRightContentButtonPressed(_ sender: UIButton) {
        tabRightContentButtonPressedHandler()
    }
    
    @IBAction func createGroupButtonPressed(_ sender: UIButton) {
//        print("createGroupButtonPressed pressed")
        tapType = .TAB_GROUP_CREATE_GROUP
        performSegue(withIdentifier: SHOW_DETAIL_VIEW_CONTROLLER, sender: self)
    }
    
    
    //
    // GroupDispatchButton
    //
    
    @IBAction func groupDispatchButtonTouchDown(_ sender: UIButton) {
        updateGroupDispatchButtonImage(type: .PRESSED)
    }
    
    @IBAction func groupDispatchButtonTouchDragExit(_ sender: UIButton) {
        updateGroupDispatchButtonImage(type: .AWAY)
    }
    
    @IBAction func groupDispatchButtonTouchUpInside(_ sender: UIButton) {
        updateGroupDispatchButtonImage(type: .AWAY)
        
        if !gVar.isHoldFormSheetView {
            gVar.isHoldFormSheetView = true
            
            // wait a moment before taking the screenshot
            let _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(showGroupDispatchModalDelayed), userInfo: nil, repeats: false)
        }
    }
    
    
    
    // MARK: - Navigation

    // Note: 使用custom cell時, prepareforsegue並不會被呼叫.
    // 因此目前做法: 定義一protocol用來觸發prepareforsegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SHOW_DETAIL_VIEW_CONTROLLER {
            let dVC = segue.destination as? DetailViewController
            dVC?.setTabSelected(type: tapType)
            
            var rowIndex = Int()
            
            // 透過點擊monitor button取得tableview cell row index
            if let index = sender as? Int {
                rowIndex = index
            }
            // 點擊tableViewCell直接取得row index
            else if let index = tableView.indexPathForSelectedRow?.row {
                rowIndex = index
            }
            
            
            switch tapType {
                
            case .TAB_GROUP_SELECT:
                dVC?.updateGroup(groupsVo[rowIndex])
                
            case .TAB_MEMBER_SELECT:
                dVC?.updateMember(membersVo[rowIndex])
                
            case .TAB_GROUP_CREATE_GROUP:
                break
                
            case .NONE:
                break
            }
        }
    }
    
}

// MARK: - Private Methods

extension MasterViewController {
    
    private func removeObserver() {
        if let _ = gVar.changeMonitorObserver {
            NotificationCenter.default.removeObserver(gVar.changeMonitorObserver!)
            gVar.changeMonitorObserver = nil
            print("removeObserver: changeMonitorObserver")
        }
    }
    
    private func addObserver() {
        if gVar.changeMonitorObserver == nil {
            gVar.changeMonitorObserver = NotificationCenter.default.addObserver(forName: CHANGE_MONITOR_NOTIFY_KEY, object: nil, queue: nil, using: changeMonitor)
            print("addObserver: changeMonitorObserver")
        }
    }
    
    private func updateDataSource() {
        searchTextField.delegate = self
    }
    
    private func reloadTestData() {
        for group in TEST_GROUPS {
            groupsVo.append(
                GroupVo(
                    name: group.name,
                    count: group.count,
                    imageName: group.imageName,
                    desc: group.desc,
                    monitorState: group.monitorState,
                    isSelected: group.isSelected
                )
            )
        }
        
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
    
    private func updateUI() {
        
        // Navigation Bar Field
        self.navigationController?.navigationBar.isHidden = true
        
        // TitleView Field
        dispatcherImage.layer.cornerRadius = dispatcherImage.frame.size.width / 2
        dispatcherImage.clipsToBounds      = true
        //dispatcherName.text = ""
        
        // TabView Filed
        tabLeftTitle.text  = str_contactTab_group
        tabRightTitle.text = str_contactTab_member
        tabBottomLeftLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
        tabBottomRightLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = true
        
        // CreateGroupView Field
        groupDispatchTitleLabel.text = str_contactTab_group_dispatch
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
    
    private func tabLeftContentButtonPressedHandler() {
        tapType = .TAB_GROUP_SELECT
        
        // update UI
        createGroupWidthConstraint.constant = 40
        createGroupTrailingConstraint.constant = 8
        createGroupoView.isHidden = false
        tabLeftIcon.image = UIImage(named: "btn_contact_group_selected")
        tabRightIcon.image = UIImage(named: "btn_contact_member_normal")
        tabLeftTitle.textColor  = UIColorFromRGB(rgbValue: UInt(TAB_SELECTED_TITLE_COLOR))
        tabRightTitle.textColor = UIColorFromRGB(rgbValue: UInt(TAB_UNSELECTED_TITLE_COLOR))
        tabBottomLeftLine.isHidden  = false
        tabBottomRightLine.isHidden = true
        groupDispatchView.isHidden = false
        
        //
        // update tableView
        //
        
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .GROUP)
        tableViewDelegate?.registerCell(cellName: GROUP_TABLE_VIEW_CELL, cellId: GROUP_TABLE_VIEW_CELL)
        tableViewDelegate?.updateGroups(groupsVo)
        
        // 預設顯示第一筆
        tableViewDelegate?.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        tableViewDelegate?.reloadUI()
    }
    
    private func tabRightContentButtonPressedHandler() {
        tapType = .TAB_MEMBER_SELECT
        
        // update UI
        createGroupWidthConstraint.constant = 0
        createGroupTrailingConstraint.constant = 0
        createGroupoView.isHidden = true
        tabLeftIcon.image = UIImage(named: "btn_contact_group_normal")
        tabRightIcon.image = UIImage(named: "btn_contact_member_selected")
        tabLeftTitle.textColor  = UIColorFromRGB(rgbValue: UInt(TAB_UNSELECTED_TITLE_COLOR))
        tabRightTitle.textColor = UIColorFromRGB(rgbValue: UInt(TAB_SELECTED_TITLE_COLOR))
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = false
        groupDispatchView.isHidden = true
        
        //
        // update tableView
        //
        
        tableViewDelegate = nil
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView, type: .MEMBER)
        tableViewDelegate?.registerCell(cellName: MEMBER_TABLE_VIEW_CELL, cellId: MEMBER_TABLE_VIEW_CELL)
        tableViewDelegate?.updateMembers(membersVo)
        
        // 預設顯示第一筆
        tableViewDelegate?.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
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
    
    private func updateGroupDispatchButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            groupDispatchImage.image = UIImage(named: "btn_contact_pressed")
            
        case .AWAY:
            groupDispatchImage.image = UIImage(named: "btn_contact_normal")
        }
    }
}

// MARK: - Notification Methods

extension MasterViewController {
    func changeMonitor(notification: Notification) -> Void {
        if let tableRowIndex = notification.userInfo?[CHANGE_MONITOR_USER_KEY] as? Int {
            let groupVo = groupsVo[tableRowIndex]
            groupVo.monitorState = !(groupVo.monitorState)

            tableViewDelegate?.updateGroup(groupVo)
            tableViewDelegate?.reloadUI()
            
            // 若點擊的監聽按鈕為當前cell的監聽按鈕, 則更新DetailViewController畫面
            if let _currentTableCellRowIndex = currentTableCellRowIndex {
                if _currentTableCellRowIndex == tableRowIndex {
                    performSegue(withIdentifier: SHOW_DETAIL_VIEW_CONTROLLER, sender: tableRowIndex)
                }
            }
           
        }
        
    }
}


// MARK: - Event Methods

extension MasterViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func showGroupDispatchModalDelayed() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showGroupDispatchModal(groupsVo: groupsVo)
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
    func activateSegue(tapType: ShowDetailViewControllerType) {
        self.tapType = tapType
        performSegue(withIdentifier: SHOW_DETAIL_VIEW_CONTROLLER, sender: self)
    }
    
    func setCurrentCellRowIndex(_ rowIndex: Int) {
        currentTableCellRowIndex = rowIndex
    }
}
