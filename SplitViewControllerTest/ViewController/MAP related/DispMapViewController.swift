//
//  DispMapViewController.swift
//  SplitViewControllerTest
//
//  Created by TzuHuan Shao on 2020/4/19.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

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

// MARK: - MapViewControllerTableViewDelegateExtend

extension DispMapViewController: MapViewControllerTableViewDelegateExtend {
    func didTapElectrFence() {
        setTapType(type: .ELECTR_FENCE)
        locateElectrFenceViewController()
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    func didTapRealTimePositioning() {
        setTapType(type: .REAL_TIME_POSITION)
        locateRealTimePositioningViewController()
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    func didTapTemporaryGroup() {
        setTapType(type: .TEMPORARY_GROUP)
        locateTemporaryGroupViewController()
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
}

// MARK: - ElectrFenceViewControllerDelegate

extension DispMapViewController: ElectrFenceViewControllerDelegate {
    // 點擊「返回」
    func electrFenceDidTapBack() {
        returnBack()
    }
    
    // 點擊「設定」
    func electrFenceDidTapEdit() {
        setTapType(type: .EDIT_ELECTR_FENCE)
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
    // 點擊「新增電子圍籬」
    func electrFenceDidTapCreate() {
        setTapType(type: .CREATE_ELECTR_FENCE)
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
}

// MARK: - RealTimePositioningViewControllerDelegate

extension DispMapViewController: RealTimePositioningViewControllerDelegate {
    // 點擊「返回」
    func realTimePositioningDidTapBack() {
        returnBack()
    }
}

// MARK: - TemporaryGroupViewControllerDelegate

extension DispMapViewController: TemporaryGroupViewControllerDelegate {
    // 點擊「返回」
    func temporaryGroupDidTapBack() {
        returnBack()
    }
}


