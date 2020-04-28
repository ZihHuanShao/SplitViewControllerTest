//
//  dp_MapViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/20.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit


class dp_MapViewControllerTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: dp_MapViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewDelegateExtend: MapViewControllerTableViewDelegateExtend?
    
    // MARK: - initializer
    
    init(dp_mapViewController: dp_MapViewController, tableView: UITableView) {
        super.init()
        self.viewController = dp_mapViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableViewDelegateExtend = self.viewController
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension dp_MapViewControllerTableViewDelegate {
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

extension dp_MapViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapFunctionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DP_MAP_TABLE_VIEW_CELL, for: indexPath) as! dp_MapTableViewCell
        
        cell.updateCell(MapFunctionType.allCases[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate
 
extension dp_MapViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print(str_map_electrFence)
            tableViewDelegateExtend?.didTapElectrFence()
        }
        else if indexPath.row == 1 {
            print(str_map_realTimePositioning)
            tableViewDelegateExtend?.didTapRealTimePositioning()
        } else if indexPath.row == 2 {
            print(str_map_temporaryGroup)
            tableViewDelegateExtend?.didTapTemporaryGroup()
        }
        
    }
}

protocol MapViewControllerTableViewDelegateExtend {
    func didTapElectrFence()
    func didTapRealTimePositioning()
    func didTapTemporaryGroup()
}
