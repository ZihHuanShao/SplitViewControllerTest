//
//  DispElectrFenceViewControllerTableViewDelegate.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/21.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

private class CellData {
    var isOpen: Bool?
    var fenceTitle: String?
    var electrFenceVo: ElectrFenceVo?
    
    init(_ electrFenceVo: ElectrFenceVo) {
        self.isOpen = false
        self.fenceTitle = electrFenceVo.title
        self.electrFenceVo = electrFenceVo
    }
}

class DispElectrFenceViewControllerTableViewDelegate: NSObject {
    
    // MARK: - Properties
    
    fileprivate weak var viewController: DispElectrFenceViewController?
    fileprivate weak var tableView: UITableView?
    fileprivate var electrFenceVo: ElectrFenceVo?
    
    fileprivate var cellsData = [CellData]()
    fileprivate var electrFencesVo = [ElectrFenceVo]()
    
    // MARK: - initializer
    
    init(dispElectrFenceViewController: DispElectrFenceViewController, tableView: UITableView) {
        super.init()
        self.viewController = dispElectrFenceViewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - Public Methods

extension DispElectrFenceViewControllerTableViewDelegate {
    func registerCell(cellName: String, cellId: String) {
        tableView?.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellId
        )
    }
    
    func reloadUI() {
        reloadCellData()
        tableView?.reloadData()
    }
    
    func updateNewElectrFenceVo(_ electrFenceVo: ElectrFenceVo?) {
        self.electrFenceVo = electrFenceVo
    }
    
}

// MARK: - Private Methods

extension DispElectrFenceViewControllerTableViewDelegate {
    private func reloadCellData() {
        if let _electrFenceVo = electrFenceVo {
            cellsData.append(CellData(_electrFenceVo))
        }
    }
}

// MARK: - UITableViewDataSource

extension DispElectrFenceViewControllerTableViewDelegate: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellsData[section].isOpen == true {
            return ElectrFenceTableMode.allCases.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DISP_ELECTR_FENCE_TABLE_VIEW_CELL, for: indexPath) as! DispElectrFenceTableViewCell
        
//        if indexPath.row == ElectrFenceTableMode.allCases.count {
            
//        } else {
            cell.updateCell(
                electrFenceTableMode: ElectrFenceTableMode.allCases[indexPath.row],
                electrFenceVo: cellsData[indexPath.section].electrFenceVo
            )
//        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension DispElectrFenceViewControllerTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cellsData[indexPath.section].isOpen == true {
            cellsData[indexPath.section].isOpen = false
            let indexes = IndexSet(integer: indexPath.section)
            tableView.reloadSections(indexes, with: .automatic)
        } else {
            cellsData[indexPath.section].isOpen = true
            let indexes = IndexSet(integer: indexPath.section)
            tableView.reloadSections(indexes, with: .automatic)
        }
    }
}
