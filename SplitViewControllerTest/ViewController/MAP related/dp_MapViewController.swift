//
//  dp_MapViewController.swift
//  SplitViewControllerTest
//
//  Created by TzuHuan Shao on 2020/4/19.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class dp_MapViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    
    fileprivate var tableViewDelegate: dp_MapViewControllerTableViewDelegate?
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
            let dVC = segue.destination as? dp_DetailViewController
            dVC?.setMainMenuType(.MAP)
            if let rowIndex = mainMenuSelectedRowIndex {
                dVC?.setMainMenuSelectedRowIndex(rowIndex)
            }
            
            dVC?.setMapTabSelected(type: tapType)
        }
    }
}

// MARK: - Public Methods

extension dp_MapViewController {
    func setMainMenuSelectedRowIndex(_ rowIndex: Int) {
        mainMenuSelectedRowIndex = rowIndex
    }
}

// MARK: - Private Methods

extension dp_MapViewController {
    private func updateDataSource() {
        tableViewDelegate = dp_MapViewControllerTableViewDelegate(dp_mapViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: DP_MAP_TABLE_VIEW_CELL, cellId: DP_MAP_TABLE_VIEW_CELL)
        
        tapType = .MAP_SELECT
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
    }
    
    private func setChildView(viewController: UIViewController) {
        self.addChild(viewController)
        viewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        self.containerView.addSubview(viewController.view)
        
        viewController.didMove(toParent: self)
    }
    
    private func changeContainerView(mapFunctionType: MapFunctionType) {
        
        switch mapFunctionType {
     
        case .ELECTR_FENCE:
            let electrFenceVC = UIStoryboard(name: STORYBOARD_NAME_DP_MAP, bundle: nil).instantiateViewController(withIdentifier: "dp_ElectrFenceViewController") as! dp_ElectrFenceViewController
            
            electrFenceVC.setDelegate(dp_mapViewController: self)
            setChildView(viewController: electrFenceVC)
            

            
        case .REAL_TIME_POSITION:
            let realTimePositioningVC = UIStoryboard(name: STORYBOARD_NAME_DP_MAP, bundle: nil).instantiateViewController(withIdentifier: "dp_RealTimePositioningViewController") as! dp_RealTimePositioningViewController
            
            realTimePositioningVC.setDelegate(dp_mapViewController: self)
            setChildView(viewController: realTimePositioningVC)

            
        case .TEMPORARY_GROUP:
            let temporaryGroupVC = UIStoryboard(name: STORYBOARD_NAME_DP_MAP, bundle: nil).instantiateViewController(withIdentifier: "dp_TemporaryGroupViewController") as! dp_TemporaryGroupViewController
    
            temporaryGroupVC.setDelegate(dp_mapViewController: self)
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

extension dp_MapViewController: MapViewControllerTableViewDelegateExtend {
    func didTapElectrFence() {
        locateElectrFenceViewController()
    }
    
    func didTapRealTimePositioning() {
        locateRealTimePositioningViewController()
    }
    
    func didTapTemporaryGroup() {
        locateTemporaryGroupViewController()
    }
}

// MARK: - ElectrFenceViewControllerDelegate

extension dp_MapViewController: ElectrFenceViewControllerDelegate {
    func electrFenceDidTapBack() {
        returnBack()
    }
    
    func electrFenceDidTapEdit() {
        setTapType(type: .EDIT_MAP_SELECT)
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
    
}

// MARK: - RealTimePositioningViewControllerDelegate

extension dp_MapViewController: RealTimePositioningViewControllerDelegate {
    func realTimePositioningDidTapBack() {
        returnBack()
    }
}

// MARK: - TemporaryGroupViewControllerDelegate

extension dp_MapViewController: TemporaryGroupViewControllerDelegate {
    func temporaryGroupDidTapBack() {
        returnBack()
    }
}


