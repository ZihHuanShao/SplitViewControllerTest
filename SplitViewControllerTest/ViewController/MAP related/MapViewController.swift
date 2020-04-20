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
    
    // TitleView Filed
    @IBOutlet weak var dispatcherButton: UIButton!
    @IBOutlet weak var dispatcherName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        // TitleView Field
         dispatcherButton.layer.cornerRadius = dispatcherButton.frame.size.width / 2
         dispatcherButton.clipsToBounds      = true
        //dispatcherName.text = ""
        
        
        tableViewDelegate?.reloadUI()
        
        performSegue(withIdentifier: SHOW_MAP_SEGUE, sender: nil)
    }
}
