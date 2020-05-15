//
//  DispElectrFenceViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/21.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit
import MapKit

class DispElectrFenceViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var functionName: UILabel!
    @IBOutlet weak var createElectrFenceButtonImage: UIImageView!
    @IBOutlet weak var createElectrFenceButton: UIButton!
    
    // MARK: - Properties
    
    var tableViewDelegate: DispElectrFenceViewControllerTableViewDelegate?
    var delegate: ElectrFenceViewControllerDelegate?
    
    fileprivate var electrFencesVo  = [ElectrFenceVo]()
    fileprivate var timer: Timer!
    
    // 用來存放目前所展開的所有圍籬的sectionIndex
    fileprivate var expandIndexesSet = Set<Int>()
    
    // 目前點擊圍籬的sectionCellIndex
    fileprivate var currentFocusSectionCellIndex: Int?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateDataSource()
        updateUI()
        
        // 每進「電子圍籬」頁面時, 要在viewWillAppear重新註冊, 而非在viewDidLoad註冊.
        // 因為在選擇顏色時彈出的視窗, 然後至選完之後重新回到畫面, 會進viewWillDisappear再進viewWillAppear,
        // 所以如果放在viewDidLoad的話, 就只會被註冊一次, 造成非預期的結果.
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 只要離開此「電子圍籬」頁面時, 一定要移除Observer, 然後下次進來時再重新註冊.
        // 不這麼做的話, 當新的圍籬建立完成時(第二次進來時), 從DispEditElectrFenceViewController post到這裡要處理
        // tableViewDelegate?.reloadUI()時, 會造成這次呼叫的tableViewDelegate?.reloadUI()
        // 當中的tableViewDelegate還是前一次註冊的資料, 為邏輯錯誤, 且也導致電子圍籬列表無法被正確刷新
        removeObserver()
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonTouchDown(_ sender: UIButton) {
        updateBackButtonImage(type: .PRESSED)
    }
    
    @IBAction func backButtonTouchDragExit(_ sender: UIButton) {
        updateBackButtonImage(type: .AWAY)
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        updateBackButtonImage(type: .AWAY)
        delegate?.electrFenceDidTapBack()
    }

    // [createElectrFence]
    
    @IBAction func createElectrFenceButtonTouchDown(_ sender: UIButton) {
        updateCreateElectrFenceButtonImage(type: .PRESSED)
    }
    
    @IBAction func createElectrFenceButtonTouchDragExit(_ sender: UIButton) {
        updateCreateElectrFenceButtonImage(type: .AWAY)
    }
    
    @IBAction func createElectrFenceButtonTouchUpInside(_ sender: UIButton) {
        updateCreateElectrFenceButtonImage(type: .AWAY)
        
        // 點擊「新增電子圍籬」就收合所有列表
        tableViewDelegate?.resetExpandElectrFences() // 重設所有展開的圍籬, 全部收合
        tableViewDelegate?.reloadUI()
        
        expandIndexesSet.removeAll()
        
        delegate?.electrFenceDidTapCreate()
    }
}
// MARK: - Public Methods

extension DispElectrFenceViewController {
    func setDelegate(dispMapViewController: DispMapViewController) {
        delegate = dispMapViewController
    }
}

// MARK: - Private Methods

extension DispElectrFenceViewController {
    private func removeObserver() {
        if let _ = gVar.Notification.updateNewElectrFenceVoObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.updateNewElectrFenceVoObserver!)
            gVar.Notification.updateNewElectrFenceVoObserver = nil
            print("removeObserver: updateNewElectrFenceVoObserver")
        }
        
        if let _ = gVar.Notification.updateExistElectrFenceVoObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.updateExistElectrFenceVoObserver!)
            gVar.Notification.updateExistElectrFenceVoObserver = nil
            print("removeObserver: updateExistElectrFenceVoObserver")
        }
        
        if let _ = gVar.Notification.editFenceScopeButtonHandlerObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.editFenceScopeButtonHandlerObserver!)
            gVar.Notification.editFenceScopeButtonHandlerObserver = nil
            print("removeObserver: editFenceScopeButtonHandlerObserver")
        }
        
        if let _ = gVar.Notification.updateElectrFenceVoObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.updateElectrFenceVoObserver!)
            gVar.Notification.updateElectrFenceVoObserver = nil
            print("removeObserver: updateElectrFenceVoObserver")
        }
        
        if let _ = gVar.Notification.borderColorButtonHandlerObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.borderColorButtonHandlerObserver!)
            gVar.Notification.borderColorButtonHandlerObserver = nil
            print("removeObserver: borderColorButtonHandlerObserver")
        }
        
        if let _ = gVar.Notification.borderColorChangedObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.borderColorChangedObserver!)
            gVar.Notification.borderColorChangedObserver = nil
            print("removeObserver: borderColorChangedObserver")
        }
        
        if let _ = gVar.Notification.sectionHeadButtonHandlerObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.sectionHeadButtonHandlerObserver!)
            gVar.Notification.sectionHeadButtonHandlerObserver = nil
            print("removeObserver: sectionHeadButtonHandlerObserver")
        }
        
        if let _ = gVar.Notification.settingButtonHandlerObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.settingButtonHandlerObserver!)
            gVar.Notification.settingButtonHandlerObserver = nil
            print("removeObserver: settingButtonHandlerObserver")
        }
        
        if let _ = gVar.Notification.enterAlarmButtonHandlerObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.enterAlarmButtonHandlerObserver!)
            gVar.Notification.enterAlarmButtonHandlerObserver = nil
            print("removeObserver: enterAlarmButtonHandlerObserver")
        }
        
        if let _ = gVar.Notification.exitAlarmButtonHandlerObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.exitAlarmButtonHandlerObserver!)
            gVar.Notification.exitAlarmButtonHandlerObserver = nil
            print("removeObserver: exitAlarmButtonHandlerObserver")
        }
        
        if let _ = gVar.Notification.reloadElectrFenceObserver {
            NotificationCenter.default.removeObserver(gVar.Notification.reloadElectrFenceObserver!)
            gVar.Notification.reloadElectrFenceObserver = nil
            print("removeObserver: reloadElectrFenceObserver")
        }
    }
    
    private func addObserver() {
        if gVar.Notification.updateNewElectrFenceVoObserver == nil {
            gVar.Notification.updateNewElectrFenceVoObserver = NotificationCenter.default.addObserver(forName: UPDATE_NEW_ELECTR_FENCE_VO_NOTIFY_KEY, object: nil, queue: nil, using: updateNewElectrFenceVo)
            print("addObserver: updateNewElectrFenceVoObserver")
        }
        
        if gVar.Notification.updateExistElectrFenceVoObserver == nil {
            gVar.Notification.updateExistElectrFenceVoObserver = NotificationCenter.default.addObserver(forName: UPDATE_EXIST_ELECTR_FENCE_VO_NOTIFY_KEY, object: nil, queue: nil, using: updateExistElectrFenceVo)
            print("addObserver: updateExistElectrFenceVoObserver")
        }
        
        if gVar.Notification.editFenceScopeButtonHandlerObserver == nil {
            gVar.Notification.editFenceScopeButtonHandlerObserver = NotificationCenter.default.addObserver(forName: EDIT_FENCE_SCOPE_BUTTON_HANDLER_NOTIFY_KEY, object: nil, queue: nil, using: editFenceScopeButtonHandler)
            print("addObserver: editFenceScopeButtonHandlerObserver")
        }
        
        if gVar.Notification.updateElectrFenceVoObserver == nil {
            gVar.Notification.updateElectrFenceVoObserver = NotificationCenter.default.addObserver(forName: UPDATE_ELECTR_FENCE_VO_NOTIFY_KEY, object: nil, queue: nil, using: updateElectrFenceVo)
            print("addObserver: updateElectrFenceVoObserver")
        }
        
        if gVar.Notification.borderColorButtonHandlerObserver == nil {
            gVar.Notification.borderColorButtonHandlerObserver = NotificationCenter.default.addObserver(forName: BORDER_COLOR_BUTTON_HANDLER_NOTIFY_KEY, object: nil, queue: nil, using: borderColorButtonHandler)
            print("addObserver: borderColorButtonHandlerObserver")
        }
        
        if gVar.Notification.borderColorChangedObserver == nil {
            gVar.Notification.borderColorChangedObserver = NotificationCenter.default.addObserver(
                forName: BORDER_COLOR_CHANGED_NOTIFY_KEY, object: nil, queue: nil, using: borderColorChanged)
            print("addObserver: borderColorChangedObserver")
        }
        
        if gVar.Notification.sectionHeadButtonHandlerObserver == nil {
            gVar.Notification.sectionHeadButtonHandlerObserver = NotificationCenter.default.addObserver(
                forName: SECTION_HEAD_BUTTON_HANDLER_NOTIFY_KEY, object: nil, queue: nil, using: sectionHeadButtonHandler)
            print("addObserver: sectionHeadButtonHandlerObserver")
        }
        
        if gVar.Notification.settingButtonHandlerObserver == nil {
            gVar.Notification.settingButtonHandlerObserver = NotificationCenter.default.addObserver(
                forName: SETTING_BUTTON_HANDLER_NOTIFY_KEY, object: nil, queue: nil, using: settingButtonHandler)
            print("addObserver: settingButtonHandlerObserver")
        }
        
        if gVar.Notification.enterAlarmButtonHandlerObserver == nil {
            gVar.Notification.enterAlarmButtonHandlerObserver = NotificationCenter.default.addObserver(
                forName: ENTER_ALARM_BUTTON_HANDLER_NOTIFY_KEY, object: nil, queue: nil, using: enterAlarmButtonHandler)
            print("addObserver: enterAlarmButtonHandlerObserver")
        }
        
        if gVar.Notification.exitAlarmButtonHandlerObserver == nil {
            gVar.Notification.exitAlarmButtonHandlerObserver = NotificationCenter.default.addObserver(
                forName: EXIT_ALARM_BUTTON_HANDLER_NOTIFY_KEY, object: nil, queue: nil, using: exitAlarmButtonHandler)
            print("addObserver: exitAlarmButtonHandlerObserver")
        }
        
        if gVar.Notification.reloadElectrFenceObserver == nil {
            gVar.Notification.reloadElectrFenceObserver = NotificationCenter.default.addObserver(forName: RELOAD_ELECTR_FENCE_NOTIFY_KEY, object: nil, queue: nil, using: reloadElectrFence)
            print("addObserver: reloadElectrFenceObserver")
        }
    }
    
    private func updateDataSource() {
        tableViewDelegate = DispElectrFenceViewControllerTableViewDelegate(dispElectrFenceViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_ELECTR_FENCE_TABLE_VIEW_CELL, cellId: DISP_ELECTR_FENCE_TABLE_VIEW_CELL)
        tableViewDelegate?.setDelegate(dispElectrFenceViewController: self)
        
        // 1. 從Server或DB取得目前所有已存在的圍籬並更新(測試中未實作)
        // 2. 當在設定新的圍籬資訊(名稱,顏色..)時, 若選擇完顏色回到畫面, 會重新進此VC的生命週期, 所以必須在這裡要更新所有圍籬的資訊, 否則電子圍籬列表會被清空, 造成非預期的錯誤
        tableViewDelegate?.updateElectrFencesVo(electrFencesVo)
        tableViewDelegate?.expandElectrFence(indexes: Array(expandIndexesSet.sorted()))
    }
    
    private func updateUI() {
        createElectrFenceButton.setTitle(str_dispElectrFence_createElectrFence, for: .normal)
        functionName.text = str_dispMap_electrFence
        
        tableViewDelegate?.reloadUI()
    }
    
    private func updateBackButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            backButtonImage.image = UIImage(named: "btn_contact_pressed")
            
        case .AWAY:
            backButtonImage.image = UIImage(named: "btn_contact_normal")
        }
    }
    
    private func updateCreateElectrFenceButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            createElectrFenceButtonImage.image = UIImage(named: "btn_contact_pressed")
            
        case .AWAY:
            createElectrFenceButtonImage.image = UIImage(named: "btn_contact_normal")
        }
    }
    
    // EX: UInt(0xFF0A0B) 轉換 RGBColorCode(r:255, g:10, b:11)
    private func getRGBColor(colorValue: UInt) -> RGBColorCode {
        let rVal = Int((colorValue & 0xFF0000) >> 16) // 0xFF -> 255
        let gVal = Int((colorValue & 0x00FF00) >> 8)  // 0x0A -> 10
        let bVal = Int(colorValue & 0x0000FF)         // 0x0B -> 11
        
        return RGBColorCode(red: rVal, green: gVal, blue: bVal)
    }
    
    // EX: RGBColorCode(r:255, g:10, b:11) 轉換 UInt(0xFF0A0B)
    private func getUIntColor(rgbColor: RGBColorCode) -> UInt {
        let rHex = (UInt(rgbColor.red)   & 0xFF) << 16 // 255 -> 0xFF0000
        let gHex = (UInt(rgbColor.green) & 0xFF) << 8  // 10  -> 0x  000A
        let bHex = UInt(rgbColor.blue)   & 0xFF        // 11  -> 0x    0B
        
        return (rHex | gHex | bHex)
    }
}

// MARK: - Notification Methods

extension DispElectrFenceViewController {

    func editFenceScopeButtonHandler(notification: Notification) -> Void {
        if let sectionIndex = notification.userInfo?[EDIT_FENCE_SCOPE_BUTTON_HANDLER_USER_KEY] as? Int {
            
            // 取得是哪一個電子圍籬被點擊
            let electrFenceVo = electrFencesVo[sectionIndex]
            
            delegate?.electrFenceDidTapEditFenceScope(electrFenceVo: electrFenceVo)
        }
    }
    
    func borderColorButtonHandler(notification: Notification) -> Void {
        if let sectionIndex = notification.userInfo?[BORDER_COLOR_BUTTON_HANDLER_USER_KEY] as? Int {
            
            // 取得是哪一個電子圍籬被點擊及顏色資訊
            if let colorValue = electrFencesVo[sectionIndex].color {
                
                // 將目前圍籬的顏色(EX: 0xFF0A0B)改為RGB值(EX: r:255, g:10, b:11)
                let colorCode = getRGBColor(colorValue: colorValue)
                
                let data = BorderColorChangedInfo(colorCode: colorCode, sectionIndex: sectionIndex)
                
                if !gVar.isHoldFormSheetView {
                    gVar.isHoldFormSheetView = true
                    gVar.presentModal = true
                    
                    // wait a moment before taking the screenshot
                    timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: (#selector(showEdidColorModalDelayed(sender:))), userInfo: data, repeats: false)
                }
            }
        }
    }
    
    func borderColorChanged(notification: Notification) -> Void {
        if let data = notification.userInfo?[BORDER_COLOR_CHANGED_USER_KEY] as? BorderColorChangedInfo {
            
            let sectionIndex = data.sectionIndex
            
            // 更新顏色
            electrFencesVo[sectionIndex].color = getUIntColor(rgbColor: data.colorCode)
            
            // 更新圍籬列表
            tableViewDelegate?.updateElectrFencesVo(electrFencesVo)
            tableViewDelegate?.expandElectrFence(indexes: Array(expandIndexesSet.sorted()))
            tableViewDelegate?.reloadUI()
            
            // 當前位於「設定頁面」
            if gVar.Map.editElectrFenceDisplayType == .EDIT {
                // 在電子圍籬列表點擊的「框線顏色」與DetailView上的設定畫面是否為同一個圍籬, 相同才刷新畫面
                if currentFocusSectionCellIndex == sectionIndex {
                    delegate?.electrFenceDidTapEdit(electrFenceVo: electrFencesVo[sectionIndex])
                }
            }
            // 當前非位於「設定畫面」, 顯示圍籬地圖
            else {
                delegate?.electrFenceReload(electrFenceVo: electrFencesVo[sectionIndex])
            }
        }
    }
    
    func updateNewElectrFenceVo(notification: Notification) -> Void {
        if let newElectrFenceVo = notification.userInfo?[UPDATE_NEW_ELECTR_FENCE_VO_USER_KEY] as? ElectrFenceVo? {
            
            if let eFenceVo = newElectrFenceVo {
                electrFencesVo.append(eFenceVo)
            }
            
            // 取得目前新建圍籬的index
            let index = electrFencesVo.count - 1
            
            // [更新列表] (MasterView)
            tableViewDelegate?.updateElectrFencesVo(electrFencesVo) // 更新所有圍籬資訊(electrFencesVo)
            tableViewDelegate?.resetExpandElectrFences() // 重設所有展開的圍籬, 全部收合
            tableViewDelegate?.expandElectrFence(index: index) // 設定新的要展開的圍籬index
            tableViewDelegate?.reloadUI()
            
            // [顯示電子圍籬及地圖] (DetailView)
            delegate?.electrFenceReload(electrFenceVo: newElectrFenceVo)
        }
    }
    
    func updateExistElectrFenceVo(notification: Notification) -> Void {
        if let existElectrFenceVo = notification.userInfo?[UPDATE_EXIST_ELECTR_FENCE_VO_USER_KEY] as? ElectrFenceVo {
            for electrFenceVo in electrFencesVo {
                if electrFenceVo.id == existElectrFenceVo.id {
                    electrFenceVo.title = existElectrFenceVo.title
                    electrFenceVo.color = existElectrFenceVo.color
                    electrFenceVo.notifyTarget = existElectrFenceVo.notifyTarget
                    electrFenceVo.autoSwitchPreferGroupEnabled = existElectrFenceVo.autoSwitchPreferGroupEnabled
                    electrFenceVo.preferGroup = existElectrFenceVo.preferGroup
                    electrFenceVo.enterAlarmEnabled = existElectrFenceVo.enterAlarmEnabled
                    electrFenceVo.enterAlarmVoicePlayEnabled = existElectrFenceVo.enterAlarmVoicePlayEnabled
                    electrFenceVo.enterAlarmVoice = existElectrFenceVo.enterAlarmVoice
                    electrFenceVo.exitAlarmEnabled = existElectrFenceVo.exitAlarmEnabled
                    electrFenceVo.exitAlarmVoicePlayEnabled = existElectrFenceVo.exitAlarmVoicePlayEnabled
                    electrFenceVo.exitAlarmVoice = existElectrFenceVo.exitAlarmVoice
                    electrFenceVo.coordinates = existElectrFenceVo.coordinates
                }
            }
            
            // [更新列表] (MasterView)
            tableViewDelegate?.updateElectrFencesVo(electrFencesVo) // 更新所有圍籬資訊(electrFencesVo)
            tableViewDelegate?.expandElectrFence(indexes: Array(expandIndexesSet.sorted()))
            tableViewDelegate?.reloadUI()
        }
    }
    
    func updateElectrFenceVo(notification: Notification) -> Void {
        if let electrFenceVo = notification.userInfo?[UPDATE_ELECTR_FENCE_VO_USER_KEY] as? ElectrFenceVo? {
            
            if let eFenceVo = electrFenceVo {
                for electrFenceVo in electrFencesVo {
                    if electrFenceVo.id == eFenceVo.id {
                        electrFenceVo.coordinates = eFenceVo.coordinates
                    }
                }
            }
        }
    }
    
    func sectionHeadButtonHandler(notification: Notification) -> Void {
        if let sectionIndex = notification.userInfo?[SECTION_HEAD_BUTTON_HANDLER_USER_KEY] as? Int {
            
            tableViewDelegate?.collapse(mode: .ENABLE)
            tableViewDelegate?.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: sectionIndex))
            tableViewDelegate?.collapse(mode: .DISABLE)
        }
    }
    
    func settingButtonHandler(notification: Notification) -> Void {
        if let sectionIndex = notification.userInfo?[SETTING_BUTTON_HANDLER_USER_KEY] as? Int {
            
            currentFocusSectionCellIndex = sectionIndex
            delegate?.electrFenceDidTapEdit(electrFenceVo: electrFencesVo[sectionIndex])
        }
    }
    
    func enterAlarmButtonHandler(notification: Notification) -> Void {
        if let sectionIndex = notification.userInfo?[ENTER_ALARM_BUTTON_HANDLER_USER_KEY] as? Int {
            
            if let enterAlarmEnabled = electrFencesVo[sectionIndex].enterAlarmEnabled {
                electrFencesVo[sectionIndex].enterAlarmEnabled = !enterAlarmEnabled
            }
            
            tableViewDelegate?.updateElectrFencesVo(electrFencesVo)
            tableViewDelegate?.expandElectrFence(indexes: Array(expandIndexesSet.sorted()))
            tableViewDelegate?.reloadUI()
            
            if gVar.Map.editElectrFenceDisplayType == .EDIT {
                // 在電子圍籬列表點擊的「進入警告」與DetailView上的設定畫面是否為同一個圍籬, 相同才刷新畫面
                if currentFocusSectionCellIndex == sectionIndex {
                    delegate?.electrFenceDidTapEdit(electrFenceVo: electrFencesVo[sectionIndex])
                }
            }
        }
    }
    
    func exitAlarmButtonHandler(notification: Notification) -> Void {
        if let sectionIndex = notification.userInfo?[EXIT_ALARM_BUTTON_HANDLER_USER_KEY] as? Int {
            
            if let exitAlarmEnabled = electrFencesVo[sectionIndex].exitAlarmEnabled {
                electrFencesVo[sectionIndex].exitAlarmEnabled = !exitAlarmEnabled
            }
            
            tableViewDelegate?.updateElectrFencesVo(electrFencesVo)
            tableViewDelegate?.expandElectrFence(indexes: Array(expandIndexesSet.sorted()))
            tableViewDelegate?.reloadUI()
            
            if gVar.Map.editElectrFenceDisplayType == .EDIT {
                // 在電子圍籬列表點擊的「離開警告」與DetailView上的設定畫面是否為同一個圍籬, 相同才刷新畫面
                if currentFocusSectionCellIndex == sectionIndex {
                    delegate?.electrFenceDidTapEdit(electrFenceVo: electrFencesVo[sectionIndex])
                }
            }
        }
    }
    
    func reloadElectrFence(notification: Notification) -> Void {
        tableViewDelegate?.expandElectrFence(indexes: Array(expandIndexesSet.sorted()))
        tableViewDelegate?.reloadUI()
    }
}

// MARK: - Event Methods

extension DispElectrFenceViewController {
    @objc func showEdidColorModalDelayed(sender: Timer) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let data = timer.userInfo as? BorderColorChangedInfo {
            let colorCode = data.colorCode
            let sectionIndex = data.sectionIndex
            
            appDelegate?.showEditColorModal(colorCode: colorCode, changeColorMode: .BORDER_COLOR, sectionIndex: sectionIndex)
        }
    }
}

// MARK: - DispElectrFenceViewControllerTableViewDelegateExtend

extension DispElectrFenceViewController: DispElectrFenceViewControllerTableViewDelegateExtend {
    func didUpdateExpandIndex(sectionIndex: Int) {
        expandIndexesSet.insert(sectionIndex)
    }
    
    func didRemoveExpandIndex(sectionIndex: Int) {
        expandIndexesSet.remove(sectionIndex)
    }
    
    func didElectrFenceReload(sectionIndex: Int) {
        delegate?.electrFenceReload(electrFenceVo: electrFencesVo[sectionIndex])
    }
}

// MARK: - Protocol

protocol ElectrFenceViewControllerDelegate {
    func electrFenceDidTapBack()   // 點擊「返回」
    func electrFenceDidTapEdit(electrFenceVo: ElectrFenceVo?)   // 點擊「設定」
    func electrFenceDidTapCreate() // 點擊「新增電子圍籬」
    func electrFenceDidTapEditFenceScope(electrFenceVo: ElectrFenceVo?) // 點擊「編輯圍籬範圍」
    
    func electrFenceReload(electrFenceVo: ElectrFenceVo?) // 重新載入顯示電子圍籬的地圖
    
}
