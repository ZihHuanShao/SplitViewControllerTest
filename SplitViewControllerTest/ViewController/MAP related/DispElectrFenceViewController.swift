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
        if let _ = gVar.updateNewElectrFenceVoObserver {
            NotificationCenter.default.removeObserver(gVar.updateNewElectrFenceVoObserver!)
            gVar.updateNewElectrFenceVoObserver = nil
            print("removeObserver: updateNewElectrFenceVoObserver")
        }
        
        if let _ = gVar.editFenceScopeButtonHandlerObserver {
            NotificationCenter.default.removeObserver(gVar.editFenceScopeButtonHandlerObserver!)
            gVar.editFenceScopeButtonHandlerObserver = nil
            print("removeObserver: editFenceScopeButtonHandlerObserver")
        }
        
        if let _ = gVar.updateElectrFenceVoObserver {
            NotificationCenter.default.removeObserver(gVar.updateElectrFenceVoObserver!)
            gVar.updateElectrFenceVoObserver = nil
            print("removeObserver: updateElectrFenceVoObserver")
        }
    }
    
    private func addObserver() {
        if gVar.updateNewElectrFenceVoObserver == nil {
            gVar.updateNewElectrFenceVoObserver = NotificationCenter.default.addObserver(forName: UPDATE_NEW_ELECTR_FENCE_VO_NOTIFY_KEY, object: nil, queue: nil, using: updateNewElectrFenceVo)
            print("addObserver: updateNewElectrFenceVoObserver")
        }
        
        
        if gVar.editFenceScopeButtonHandlerObserver == nil {
            gVar.editFenceScopeButtonHandlerObserver = NotificationCenter.default.addObserver(forName: EDIT_FENCE_SCOPE_BUTTON_HANDLER_NOTIFY_KEY, object: nil, queue: nil, using: editFenceScopeButtonHandler)
            print("addObserver: editFenceScopeButtonHandlerObserver")
        }
        
        
        if gVar.updateElectrFenceVoObserver == nil {
            gVar.updateElectrFenceVoObserver = NotificationCenter.default.addObserver(forName: UPDATE_ELECTR_FENCE_VO_NOTIFY_KEY, object: nil, queue: nil, using: updateElectrFenceVo)
            print("addObserver: updateElectrFenceVoObserver")
        }
    }
    
    private func updateDataSource() {
        tableViewDelegate = DispElectrFenceViewControllerTableViewDelegate(dispElectrFenceViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_ELECTR_FENCE_TABLE_VIEW_CELL, cellId: DISP_ELECTR_FENCE_TABLE_VIEW_CELL)
           
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
    
    func updateNewElectrFenceVo(notification: Notification) -> Void {
        if let electrFenceVo = notification.userInfo?[UPDATE_NEW_ELECTR_FENCE_VO_USER_KEY] as? ElectrFenceVo? {
            
            if let eFenceVo = electrFenceVo {
                electrFencesVo.append(eFenceVo)
            }
            
            // 更新列表 (MasterView)
            tableViewDelegate?.updateNewElectrFenceVo(electrFenceVo)
            tableViewDelegate?.reloadUI()
            
            // 顯示電子圍籬及地圖 (DetailView)
            delegate?.electrFenceReload(electrFenceVo: electrFenceVo)
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
}


// MARK: - Protocol

protocol ElectrFenceViewControllerDelegate {
    func electrFenceDidTapBack()   // 點擊「返回」
    func electrFenceDidTapEdit()   // 點擊「設定」
    func electrFenceDidTapCreate() // 點擊「新增電子圍籬」
    func electrFenceDidTapEditFenceScope(electrFenceVo: ElectrFenceVo?) // 點擊「編輯圍籬範圍」
    
    func electrFenceReload(electrFenceVo: ElectrFenceVo?) // 重新載入顯示電子圍籬的地圖
    
}
