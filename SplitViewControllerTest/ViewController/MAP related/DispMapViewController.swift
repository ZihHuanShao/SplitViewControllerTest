//
//  DispMapViewController.swift
//  SplitViewControllerTest
//
//  Created by TzuHuan Shao on 2020/4/19.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit
import MapKit

class DispMapViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    
    fileprivate var tableViewDelegate: DispMapViewControllerTableViewDelegate?
    fileprivate var mainMenuSelectedRowIndex: Int?
    fileprivate var tapType = ShowMapSegueType.NONE
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDataSource()
        updateUI()
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("")
    }
    // MARK: - Actions
    
    @IBAction func dispatcherSetting(_ sender: UIButton) {
        print("dispatcherSetting pressed")
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //showPttSegue
        if segue.identifier == SHOW_MAP_SEGUE {
            let dVC = segue.destination as? DetailViewController
            dVC?.setMainMenuType(.MAP)
            if let rowIndex = mainMenuSelectedRowIndex {
                dVC?.setMainMenuSelectedRowIndex(rowIndex)
            }
            
            // 「新增電子圍籬」的資訊: 建立新的圍籬
            if let createModeInfo = sender as? EditElectrFenceDisplayCreateModeInfo {
                dVC?.setEditElectrFenceDisplayType(createModeInfo.type)
                dVC?.updateNewElectrFenceCoordinates(createModeInfo.coordinates)
            }
            // 電子圍籬「設定」的資訊: 編輯既有圍籬
            else if let editModeInfo = sender as? EditElectrFenceDisplayEditModeInfo {
                dVC?.setEditElectrFenceDisplayType(editModeInfo.type)
            }
            // 1. 新的圍籬建立後要在地圖上顯示圍籬的資訊
            // 2. 「編輯圍籬範圍」的資訊
            else if let electrFenceVo = sender as? ElectrFenceVo? {
                dVC?.updateElectrFenceVo(electrFenceVo)
            }
            
            
            
            dVC?.setMapTabSelected(type: tapType)
        }
    }
}

// MARK: - Public Methods

extension DispMapViewController {
    func setMainMenuSelectedRowIndex(_ rowIndex: Int) {
        mainMenuSelectedRowIndex = rowIndex
    }
}

// MARK: - Private Methods

extension DispMapViewController {
    private func removeObserver() {
        if let _ = gVar.createElectrFenceSettingObserver {
            NotificationCenter.default.removeObserver(gVar.createElectrFenceSettingObserver!)
            gVar.createElectrFenceSettingObserver = nil
            print("removeObserver: createElectrFenceSettingObserver")
        }
    }
    
    private func addObserver() {
        if gVar.createElectrFenceSettingObserver == nil {
            gVar.createElectrFenceSettingObserver = NotificationCenter.default.addObserver(forName: CREATE_ELECTR_FENCE_SETTING_NOTIFY_KEY, object: nil, queue: nil, using: createElectrFenceSetting)
            
            print("addObserver: createElectrFenceSettingObserver")
        }
    }
    
    private func updateDataSource() {
        tableViewDelegate = DispMapViewControllerTableViewDelegate(dispMapViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DISP_MAP_TABLE_VIEW_CELL, cellId: DISP_MAP_TABLE_VIEW_CELL)
        
        setTapType(type: .MAP)
    }
    
    private func setTapType(type: ShowMapSegueType) {
        tapType = type
    }
    
    private func updateUI() {
        tableViewDelegate?.reloadUI()
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    private func returnBack() {
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        tableView.isHidden = false
        setTapType(type: .MAP)
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    private func setChildView(viewController: UIViewController) {
        self.addChild(viewController)
        viewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(viewController.view)
        
        viewController.didMove(toParent: self)
    }
    
    private func changeContainerView(mapFunctionType: MapFunctionType) {
        
        switch mapFunctionType {
     
        // 電子圍籬
        case .ELECTR_FENCE:
            let electrFenceVC = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispElectrFenceViewController") as! DispElectrFenceViewController
            
            electrFenceVC.setDelegate(dispMapViewController: self)
            setChildView(viewController: electrFenceVC)
            

        // 即時定位
        case .REAL_TIME_POSITION:
            let realTimePositioningVC = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispRealTimePositioningViewController") as! DispRealTimePositioningViewController
            
            realTimePositioningVC.setDelegate(dispMapViewController: self)
            setChildView(viewController: realTimePositioningVC)

        // 臨時群組
        case .TEMPORARY_GROUP:
            let temporaryGroupVC = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispTemporaryGroupViewController") as! DispTemporaryGroupViewController
    
            temporaryGroupVC.setDelegate(dispMapViewController: self)
            setChildView(viewController: temporaryGroupVC)
        }
        
        // tableView與ContainerView同一層, 且ContainerView是用來顯示 電子圍籬/即時定位/臨時群組
        // 所以如果要顯示ContainerView則必須將tableView隱藏
        tableView.isHidden = true
    }
    
    private func locateElectrFenceViewController() {
        changeContainerView(mapFunctionType: .ELECTR_FENCE)
    }
    
    private func locateRealTimePositioningViewController() {
        changeContainerView(mapFunctionType: .REAL_TIME_POSITION)
    }
    
    private func locateTemporaryGroupViewController() {
        changeContainerView(mapFunctionType: .TEMPORARY_GROUP)
    }
}

// MARK: - Notification Methods

extension DispMapViewController {
    func createElectrFenceSetting(notification: Notification) {
        setTapType(type: .EDIT_ELECTR_FENCE)
        
        if let electrFenceCoordinates = notification.userInfo?[CREATE_ELECTR_FENCE_SETTING_USER_KEY] as? [CLLocationCoordinate2D] {
            
            let data = EditElectrFenceDisplayCreateModeInfo(coordinates: electrFenceCoordinates)
            
            performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: data)
        }
        
    }
}

// MARK: - MapViewControllerTableViewDelegateExtend 電子圍籬/ 即時定位/ 臨時群組

extension DispMapViewController: MapViewControllerTableViewDelegateExtend {
    // 點擊「電子圍籬」
    func didTapElectrFence() {
        setTapType(type: .ELECTR_FENCE)
        locateElectrFenceViewController()
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    // 點擊「即時定位」
    func didTapRealTimePositioning() {
        setTapType(type: .REAL_TIME_POSITION)
        locateRealTimePositioningViewController()
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    // 點擊「臨時群組」
    func didTapTemporaryGroup() {
        setTapType(type: .TEMPORARY_GROUP)
        locateTemporaryGroupViewController()
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
}

// MARK: - ElectrFenceViewControllerDelegate 「電子圍籬」列表

extension DispMapViewController: ElectrFenceViewControllerDelegate {
    // 點擊「返回」
    func electrFenceDidTapBack() {
        returnBack()
    }
    
    // 點擊「設定」
    func electrFenceDidTapEdit() {
        setTapType(type: .EDIT_ELECTR_FENCE)
        
        let data = EditElectrFenceDisplayEditModeInfo()
            
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: data)
    }
    
    // 點擊「新增電子圍籬」
    func electrFenceDidTapCreate() {
        setTapType(type: .CREATE_ELECTR_FENCE)
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    // 點擊「編輯圍籬範圍」
    func electrFenceDidTapEditFenceScope(electrFenceVo: ElectrFenceVo?) {
        setTapType(type: .EDIT_FENCE_SCOPE)
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: electrFenceVo)
    }
    
    // 重新載入顯示電子圍籬的地圖
//    func electrFenceReload(electrFenceCoordinates: [CLLocationCoordinate2D]?) {
//
//        setTapType(type: .AFTER_CREATE_ELECTR_FENCE)
//        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: electrFenceCoordinates)
//    }
    
    func electrFenceReload(electrFenceVo: ElectrFenceVo?) {
        
        setTapType(type: .AFTER_CREATE_ELECTR_FENCE)
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: electrFenceVo)
    }
}

// MARK: - RealTimePositioningViewControllerDelegate 「即時定位」列表

extension DispMapViewController: RealTimePositioningViewControllerDelegate {
    // 點擊「返回」
    func realTimePositioningDidTapBack() {
        returnBack()
    }
}

// MARK: - TemporaryGroupViewControllerDelegate 「臨時群組」列表

extension DispMapViewController: TemporaryGroupViewControllerDelegate {
    // 點擊「返回」
    func temporaryGroupDidTapBack() {
        returnBack()
    }
}


