//
//  dp_RealTimePositioningViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/22.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class dp_RealTimePositioningViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_RealTimePositioningViewController?
    fileprivate weak var tableView: UITableView?
    
    // MARK: - initializer
    
    init(dp_realTimePositioningViewController: dp_RealTimePositioningViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_realTimePositioningViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension dp_RealTimePositioningViewControllerTableViewDelegate {
    func registerCell(cellName: String, cellId: String) {
        tableView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellId
        )
    }
    
    func reloadUI() {
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension dp_RealTimePositioningViewControllerTableViewDelegate: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension dp_RealTimePositioningViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
