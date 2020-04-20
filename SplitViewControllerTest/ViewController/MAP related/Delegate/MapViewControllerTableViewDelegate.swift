//
//  MapViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/20.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit


class MapViewControllerTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: MapViewController?
    fileprivate weak var tableView: UITableView?
    
    // MARK: - initializer
    
    init(mapViewController: MapViewController, tableView: UITableView) {
        super.init()
        self.viewController = mapViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Public Methods

extension MapViewControllerTableViewDelegate {
    func reloadUI() {
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension MapViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SHOW", for: indexPath)
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
 
extension MapViewControllerTableViewDelegate: UITableViewDelegate {
    
}

