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
    @IBOutlet weak var mapFunctionName: UILabel!
    @IBOutlet weak var backButtonImage: UIImageView!
    
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
    
    @IBAction func backButtonTouchDown(_ sender: UIButton) {
        updateBackButtonImage(type: .PRESSED)
    }
    @IBAction func backButtonTouchDragExit(_ sender: UIButton) {
        updateBackButtonImage(type: .AWAY)
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        updateBackButtonImage(type: .AWAY)
        
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
    
    private func updateBackButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            backButtonImage.image = UIImage(named: "btn_contact_pressed")
            
        case .AWAY:
            backButtonImage.image = UIImage(named: "btn_contact_normal")
        }
    }
}

extension MapViewController: MapViewControllerTableViewDelegateExtend {
    func didTapElectrFence() {
        let electrFenceViewController = UIStoryboard(name: STORYBOARD_NAME_MAP, bundle: nil).instantiateViewController(withIdentifier: "ElectrFenceViewController") as! ElectrFenceViewController
        
    }
    
    func didTapTrajectoryTracking() {
        return
    }
    
    func didTapTemporaryGroup() {
        return
    }
    
    
}
