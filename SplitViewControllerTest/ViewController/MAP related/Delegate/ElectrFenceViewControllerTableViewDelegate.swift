//
//  ElectrFenceViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/21.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class ElectrFenceViewControllerTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: ElectrFenceViewController?
    fileprivate weak var tableView: UITableView?
    
    // MARK: - initializer
    
    init(electrFenceViewController: ElectrFenceViewController, tableView: UITableView) {
        super.init()
        self.viewController = electrFenceViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension ElectrFenceViewControllerTableViewDelegate {
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

extension ElectrFenceViewControllerTableViewDelegate: UITableViewDataSource {
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

extension ElectrFenceViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


