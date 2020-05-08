//
//  DispMapViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/20.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit


class DispMapViewControllerTableViewDelegate: NSObject {
    // MARK: - Properties
    
    fileprivate weak var viewController: DispMapViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var tableViewDelegateExtend: MapViewControllerTableViewDelegateExtend?
    
    // MARK: - initializer
    
    init(dispMapViewController: DispMapViewController, tableView: UITableView) {
        super.init()
        self.viewController = dispMapViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableViewDelegateExtend = self.viewController
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension DispMapViewControllerTableViewDelegate {
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

extension DispMapViewControllerTableViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapFunctionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DISP_MAP_TABLE_VIEW_CELL, for: indexPath) as! DispMapTableViewCell
        
        cell.updateCell(MapFunctionType.allCases[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate
 
extension DispMapViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch MapFunctionType.allCases[indexPath.row] {
        
        // 點擊「電子圍籬」
        case .ELECTR_FENCE:
            print(str_dispMap_electrFence)
            tableViewDelegateExtend?.didTapElectrFence()
        
        // 點擊「即時定位」
        case .REAL_TIME_POSITION:
            print(str_dispMap_realTimePositioning)
            tableViewDelegateExtend?.didTapRealTimePositioning()
        
        // 點擊「臨時群組」
        case .TEMPORARY_GROUP:
            print(str_dispMap_temporaryGroup)
            tableViewDelegateExtend?.didTapTemporaryGroup()
        }
        
    }
}

// MARK: - Protocol

protocol MapViewControllerTableViewDelegateExtend {
    func didTapElectrFence()
    func didTapRealTimePositioning()
    func didTapTemporaryGroup()
}
