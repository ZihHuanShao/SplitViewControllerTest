//
//  dp_ElectrFenceViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/21.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class dp_ElectrFenceViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_ElectrFenceViewController?
    fileprivate weak var tableView: UITableView?
    
    // MARK: - initializer
    
    init(dp_electrFenceViewController: dp_ElectrFenceViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_electrFenceViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension dp_ElectrFenceViewControllerTableViewDelegate {
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

extension dp_ElectrFenceViewControllerTableViewDelegate: UITableViewDataSource {
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

extension dp_ElectrFenceViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
