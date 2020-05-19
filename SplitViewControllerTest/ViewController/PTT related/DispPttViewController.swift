//
//  DispPttViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/4/19.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class DispPttViewController: UIViewController {

    // MARK: - IBOutlet

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
    @IBOutlet weak var groupDispatchButton: UIButton!
    @IBOutlet weak var groupDispatchView: UIView!
    @IBOutlet weak var groupDispatchButtonImage: UIImageView!
    @IBOutlet weak var groupDispatchHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Properties
    
    fileprivate var tapType = ShowPttSegueType.NONE
    fileprivate var tabSelected = PttContactTabType.NONE
    fileprivate var tableViewDelegate: DispPttViewControllerTableViewDelegate?
    fileprivate var mainMenuSelectedRowIndex: Int?
    
    // Original Test data

    fileprivate var groupsVo     = [GroupVo]() // 該teamwork所有已被加入調度的群組列表
    fileprivate var allGroupsVo  = [GroupVo]() // 該teamwork所有的群組列表
    fileprivate var membersVo    = [MemberVo]()

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
        
        // 預設顯示「群組」列表
        tabLeftContentButtonPressed(UIButton())
        tableViewDelegate?.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeObserver()
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
    
    // tabLeftContentButton (群組)
    
    @IBAction func tabLeftContentButtonPressed(_ sender: UIButton) {
        tabLeftContentButtonPressedHandler()
    }
    
    // tabRightContentButton (聯絡人)
    
    @IBAction func tabRightContentButtonPressed(_ sender: UIButton) {
        tabRightContentButtonPressedHandler()
    }
    
    // createGroupButtonPressed (建立群組)
    
    @IBAction func createGroupButtonPressed(_ sender: UIButton) {
//        print("createGroupButtonPressed pressed")
        tapType = .TAB_GROUP_CREATE_GROUP
        performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: self)
    }
    
    
    // [GroupDispatchButton] (群組調度)
    
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
        
        if segue.identifier == SHOW_PTT_SEGUE {
            let dVC = segue.destination as? DetailViewController
            dVC?.setMainMenuType(.PTT)
            
            // 若點擊「群組」或「聯絡人」才會有值
            if let rowIndex = mainMenuSelectedRowIndex {
                dVC?.setMainMenuSelectedRowIndex(rowIndex)
            }
            
            // 點擊的類型是哪一種(群組/ 群組中的「建立群組」/ 聯絡人)
            dVC?.setPttTabSelected(type: tapType)
            
            var rowIndex = Int()
            
            // 1. 透過點擊monitor button取得tableview cell row index
            // 2. 在加入要調度的群組之後, 要呈現哪個群組的資訊
            if let index = sender as? Int {
                rowIndex = index
            }
            // 點擊tableViewCell直接取得row index
            else if let index = tableView.indexPathForSelectedRow?.row {
                rowIndex = index
            }
            
            
            switch tapType {
                
            case .TAB_GROUP_SELECT:
                if groupsVo.count != 0 {
                    dVC?.updateGroup(groupsVo[rowIndex])
                }
                
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

// MARK: - Public Methods

extension DispPttViewController {
    func setMainMenuSelectedRowIndex(_ rowIndex: Int) {
        mainMenuSelectedRowIndex = rowIndex
    }
}

// MARK: - Private Methods

extension DispPttViewController {
    
    private func removeObserver() {
        if let _ = gVar.Notification.changeMonitorObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.changeMonitorObserver!)
            gVar.Notification.changeMonitorObserver = nil
            print("removeObserver: changeMonitorObserver")
        }
        
        if let _ = gVar.Notification.reloadGroupTableViewObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.reloadGroupTableViewObserver!)
            gVar.Notification.reloadGroupTableViewObserver = nil
            print("removeObserver: reloadGroupTableViewObserver")
        }
    }
    
    private func addObserver() {
        if gVar.Notification.changeMonitorObserver == nil {
            gVar.Notification.changeMonitorObserver = NotificationCenter.default.addObserver(forName: CHANGE_MONITOR_NOTIFY_KEY, object: nil, queue: nil, using: changeMonitor)
            print("addObserver: changeMonitorObserver")
        }
        
        if gVar.Notification.reloadGroupTableViewObserver == nil {
            gVar.Notification.reloadGroupTableViewObserver = NotificationCenter.default.addObserver(forName: RELOAD_GROUP_TABLE_VIEW_NOTIFY_KEY, object: nil, queue: nil, using: reloadGroupTableView)
            print("addObserver: reloadGroupTableViewObserver")
        }
        
        
    }
    
    private func updateDataSource() {
        searchTextField.delegate = self
    }
    
    private func reloadTestData() {
        allGroupsVo.removeAll()
        groupsVo.removeAll()
        membersVo.removeAll()
        
        // EX: 取得此teamwork所有群組
        for group in TEST_GROUPS {
            allGroupsVo.append(
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
        
        // EX: 取得此teamwork目前有被加入調度的群組
        for groupVo in allGroupsVo {
            if groupVo.isSelected == true {
                groupsVo.append(groupVo)
            }
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
        
        // TabView Filed
        tabLeftTitle.text  = str_dispPtt_contactTab_group
        tabRightTitle.text = str_dispPtt_contactTab_member
        tabBottomLeftLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
        tabBottomRightLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = true
        
        // CreateGroupView Field
        groupDispatchButton.setTitle(str_dispPtt_contactTab_group_dispatch, for: .normal)
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
        groupDispatchHeightConstraint.constant = 40
        
        //
        // update tableView
        //
        
        tableViewDelegate = nil
        tableViewDelegate = DispPttViewControllerTableViewDelegate(dispPttViewController: self, tableView: tableView, type: .GROUP)
        tableViewDelegate?.registerCell(cellName: DISP_GROUP_TABLE_VIEW_CELL, cellId: DISP_GROUP_TABLE_VIEW_CELL)
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
        groupDispatchHeightConstraint.constant = 0
        
        //
        // update tableView
        //
        
        tableViewDelegate = nil
        tableViewDelegate = DispPttViewControllerTableViewDelegate(dispPttViewController: self, tableView: tableView, type: .MEMBER)
        tableViewDelegate?.registerCell(cellName: DISP_MEMBER_TABLE_VIEW_CELL, cellId: DISP_MEMBER_TABLE_VIEW_CELL)
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
            groupDispatchButtonImage.image = UIImage(named: "btn_contact_pressed")
            
        case .AWAY:
            groupDispatchButtonImage.image = UIImage(named: "btn_contact_normal")
        }
    }
    
    private func updateAllgroupsVo(_ changedGroupVo: GroupVo) {
        for groupVo in allGroupsVo {
            if groupVo.id == changedGroupVo.id {
                groupVo.name = changedGroupVo.name
                groupVo.count = changedGroupVo.count
                groupVo.imageName = changedGroupVo.imageName
                groupVo.desc = changedGroupVo.desc
                groupVo.monitorState = changedGroupVo.monitorState
                groupVo.isSelected = changedGroupVo.isSelected
            }
        }
    }
}

// MARK: - Notification Methods

extension DispPttViewController {
    func changeMonitor(notification: Notification) -> Void {
        if let tableRowIndex = notification.userInfo?[CHANGE_MONITOR_USER_KEY] as? Int {
            
            // 取得目前所點擊cell的groupVo並更新監聽狀態
            let monitorState = groupsVo[tableRowIndex].monitorState
            groupsVo[tableRowIndex].monitorState = !monitorState

            tableViewDelegate?.updateGroup(groupsVo[tableRowIndex])
            tableViewDelegate?.reloadUI()
            
            updateAllgroupsVo(groupsVo[tableRowIndex])
            
            // 若點擊的監聽按鈕為當前cell的監聽按鈕, 則更新DetailViewController畫面
            if let _currentTableCellRowIndex = currentTableCellRowIndex {
                if _currentTableCellRowIndex == tableRowIndex {
                    performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: tableRowIndex)
                }
            }
           
        }
    }
    
    func reloadGroupTableView(notification: Notification) -> Void {
        if let updatedGroupsVo = notification.userInfo?[RELOAD_GROUP_TABLE_VIEW_USER_KEY] as? [GroupVo]? {
            groupsVo.removeAll()
            
            if let updatedGroupsVo = updatedGroupsVo {
                for groupVo in updatedGroupsVo {
                    groupsVo.append(groupVo)
                }
            }
            
            tableViewDelegate?.updateGroups(groupsVo)
            tableViewDelegate?.reloadUI()
            
            // 現在沒有選擇任何要調度的群組, 群組列表為空
            if groupsVo.count == 0 {
                performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: self)
            }
        }
    }
}


// MARK: - Event Methods

extension DispPttViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func showGroupDispatchModalDelayed() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        // 群組列表為空時
        if groupsVo.count == 0 {
            tableViewDelegate?.resetDidSelectedRow()
        }
        
        appDelegate?.showGroupDispatchModal(groupsVo: allGroupsVo)
    }
}

// MARK: - UITextFieldDelegate

extension DispPttViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - MasterViewTableViewExtendDelegate

extension DispPttViewController: PttViewControllerTableViewDelegateExtend {
    func activateSegue(tapType: ShowPttSegueType) {
        self.tapType = tapType
        performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: self)
    }
    
    func setCurrentCellRowIndex(_ rowIndex: Int) {
        currentTableCellRowIndex = rowIndex
    }

    func showGroup(withRowIndex: Int) {
        performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: withRowIndex)
    }
}
