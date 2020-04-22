//
//  MapViewController.swift
//  SplitViewControllerTest
//
//  Created by TzuHuan Shao on 2020/4/19.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    
    fileprivate var tableViewDelegate: MapViewControllerTableViewDelegate?
    fileprivate var mainMenuSelectedRowIndex: Int?
    
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
        //showDetailViewController
        if segue.identifier == SHOW_MAP_SEGUE {
            let dVC = segue.destination as? DetailViewController
            dVC?.setMainMenuType(.MAP)
            if let rowIndex = mainMenuSelectedRowIndex {
                dVC?.setMainMenuSelectedRowIndex(rowIndex)
            }
        }
    }
}

// MARK: - Public Methods

extension MapViewController {
    func setMainMenuSelectedRowIndex(_ rowIndex: Int) {
        mainMenuSelectedRowIndex = rowIndex
    }
}

// MARK: - Private Methods

extension MapViewController {
    private func updateDataSource() {
        tableViewDelegate = MapViewControllerTableViewDelegate(mapViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: MAP_TABLE_VIEW_CELL, cellId: MAP_TABLE_VIEW_CELL)
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
            let electrFenceVC = UIStoryboard(name: STORYBOARD_NAME_MAP, bundle: nil).instantiateViewController(withIdentifier: "ElectrFenceViewController") as! ElectrFenceViewController
            
            electrFenceVC.setDelegate(mapViewController: self)
            setChildView(viewController: electrFenceVC)
            

            
        case .REAL_TIME_POSITION:
            let realTimePositioningVC = UIStoryboard(name: STORYBOARD_NAME_MAP, bundle: nil).instantiateViewController(withIdentifier: "RealTimePositioningViewController") as! RealTimePositioningViewController
            
            realTimePositioningVC.setDelegate(mapViewController: self)
            setChildView(viewController: realTimePositioningVC)

            
        case .TEMPORARY_GROUP:
            let temporaryGroupVC = UIStoryboard(name: STORYBOARD_NAME_MAP, bundle: nil).instantiateViewController(withIdentifier: "TemporaryGroupViewController") as! TemporaryGroupViewController
    
            temporaryGroupVC.setDelegate(mapViewController: self)
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

extension MapViewController: MapViewControllerTableViewDelegateExtend {
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

extension MapViewController: ElectrFenceViewControllerDelegate {
    func electrFenceDidTapBack() {
        returnBack()
    }
}

// MARK: - RealTimePositioningViewControllerDelegate

extension MapViewController: RealTimePositioningViewControllerDelegate {
    func realTimePositioningDidTapBack() {
        returnBack()
    }
}

// MARK: - TemporaryGroupViewControllerDelegate

extension MapViewController: TemporaryGroupViewControllerDelegate {
    func temporaryGroupDidTapBack() {
        returnBack()
    }
}


