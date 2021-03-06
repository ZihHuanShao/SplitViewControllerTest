//
//  dp_PttViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/4/19.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class dp_PttViewController: UIViewController {

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
    
    
    // MARK: - Properties
    
    fileprivate var tapType = ShowPttSegueType.NONE
    fileprivate var tabSelected = PttContactTabType.NONE
    fileprivate var tableViewDelegate: dp_PttViewControllerTableViewDelegate?
    fileprivate var mainMenuSelectedRowIndex: Int?
    
    // Original Test data

    fileprivate var groupsVo  = [dp_GroupVo]()
    fileprivate var membersVo = [dp_MemberVo]()

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
        performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: self)
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
        
        if segue.identifier == SHOW_PTT_SEGUE {
            let dVC = segue.destination as? dp_DetailViewController
            dVC?.setMainMenuType(.PTT)
            
            // 若點擊「群組」或「聯絡人」才會有值
            if let rowIndex = mainMenuSelectedRowIndex {
                dVC?.setMainMenuSelectedRowIndex(rowIndex)
            }
            
            // 點擊的類型是哪一種(群組/ 群組中的「建立群組」/ 聯絡人)
            dVC?.setPttTabSelected(type: tapType)
            
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

// MARK: - Public Methods

extension dp_PttViewController {
    func setMainMenuSelectedRowIndex(_ rowIndex: Int) {
        mainMenuSelectedRowIndex = rowIndex
    }
}

// MARK: - Private Methods

extension dp_PttViewController {
    
    private func removeObserver() {
        if let _ = gVar.changeMonitorObserver {
            NotificationCenter.default.removeObserver(gVar.changeMonitorObserver!)
            gVar.changeMonitorObserver = nil
            print("removeObserver: changeMonitorObserver")
        }
        
        if let _ = gVar.reloadGroupTableViewObserver {
            NotificationCenter.default.removeObserver(gVar.reloadGroupTableViewObserver!)
            gVar.reloadGroupTableViewObserver = nil
            print("removeObserver: reloadGroupTableViewObserver")
        }
    }
    
    private func addObserver() {
        if gVar.changeMonitorObserver == nil {
            gVar.changeMonitorObserver = NotificationCenter.default.addObserver(forName: CHANGE_MONITOR_NOTIFY_KEY, object: nil, queue: nil, using: changeMonitor)
            print("addObserver: changeMonitorObserver")
        }
        
        if gVar.reloadGroupTableViewObserver == nil {
            gVar.reloadGroupTableViewObserver = NotificationCenter.default.addObserver(forName: RELOAD_GROUP_TABLE_VIEW_NOTIFY_KEY, object: nil, queue: nil, using: reloadGroupTableView)
            print("addObserver: reloadGroupTableViewObserver")
        }
        
        
    }
    
    private func updateDataSource() {
        searchTextField.delegate = self
    }
    
    private func reloadTestData() {
        for group in TEST_GROUPS {
            groupsVo.append(
                dp_GroupVo(
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
                dp_MemberVo(
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
        tabLeftTitle.text  = str_contactTab_group
        tabRightTitle.text = str_contactTab_member
        tabBottomLeftLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
        tabBottomRightLine.backgroundColor = UIColorFromRGB(rgbValue: UInt(TAB_BOTTOM_LINE_COLOR))
        tabBottomLeftLine.isHidden  = true
        tabBottomRightLine.isHidden = true
        
        // CreateGroupView Field
        groupDispatchButton.setTitle(str_contactTab_group_dispatch, for: .normal)
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
        tableViewDelegate = dp_PttViewControllerTableViewDelegate(dp_pttViewController: self, tableView: tableView, type: .GROUP)
        tableViewDelegate?.registerCell(cellName: DP_GROUP_TABLE_VIEW_CELL, cellId: DP_GROUP_TABLE_VIEW_CELL)
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
        tableViewDelegate = dp_PttViewControllerTableViewDelegate(dp_pttViewController: self, tableView: tableView, type: .MEMBER)
        tableViewDelegate?.registerCell(cellName: DP_MEMBER_TABLE_VIEW_CELL, cellId: DP_MEMBER_TABLE_VIEW_CELL)
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
}

// MARK: - Notification Methods

extension dp_PttViewController {
    func changeMonitor(notification: Notification) -> Void {
        if let tableRowIndex = notification.userInfo?[CHANGE_MONITOR_USER_KEY] as? Int {
            let dp_groupVo = groupsVo[tableRowIndex]
            dp_groupVo.monitorState = !(dp_groupVo.monitorState)

            tableViewDelegate?.updateGroup(dp_groupVo)
            tableViewDelegate?.reloadUI()
            
            // 若點擊的監聽按鈕為當前cell的監聽按鈕, 則更新dp_DetailViewController畫面
            if let _currentTableCellRowIndex = currentTableCellRowIndex {
                if _currentTableCellRowIndex == tableRowIndex {
                    performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: tableRowIndex)
                }
            }
           
        }
    }
    
    func reloadGroupTableView(notification: Notification) -> Void {
        tableViewDelegate?.reloadUI()
    }
}


// MARK: - Event Methods

extension dp_PttViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func showGroupDispatchModalDelayed() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showGroupDispatchModal(groupsVo: groupsVo)
    }
}

// MARK: - UITextFieldDelegate

extension dp_PttViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - MasterViewTableViewExtendDelegate

extension dp_PttViewController: PttViewControllerTableViewDelegateExtend {
    func activateSegue(tapType: ShowPttSegueType) {
        self.tapType = tapType
        performSegue(withIdentifier: SHOW_PTT_SEGUE, sender: self)
    }
    
    func setCurrentCellRowIndex(_ rowIndex: Int) {
        currentTableCellRowIndex = rowIndex
    }
}
