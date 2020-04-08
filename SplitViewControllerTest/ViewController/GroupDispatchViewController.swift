//
//  GroupDispatchViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/7.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class GroupDispatchViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var cancelButtonView: UIButton!
    @IBOutlet weak var finishButtonView: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    // tableview
    fileprivate var tableViewDelegate: GroupDispatchTableViewDelegate?
    
    // Original Test data
    let groups = ["MaxkitDemo","Test Group","Fred Group","Fred Group2","Fred Group3"]
    let members = ["Martin","Charley","Fred","Michael","MayMay"]
    let groupNumbers = [6, 13, 18, 26, 50]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDataSource()
        updateGesture()
        updateUI()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateSelfViewSize()
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissOverlay()
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissOverlay()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
    }
    
}

// MARK: - UITextFieldDelegate

extension GroupDispatchViewController: UITextFieldDelegate {
    func setSearchTextFieldDataSource() {
        searchTextField.delegate = self
    }
}

// MARK: - Private Methods

extension GroupDispatchViewController {
    private func updateSelfViewSize() {
        //
        // 整體外觀
        //

        let width1 = UserDefaults.standard.float(forKey: SPLIT_MASTER_VIEW_CONTROLLER_WIDTH)
        let width2 = UserDefaults.standard.float(forKey: SPLIT_DETAIL_VIEW_CONTROLLER_WIDTH)
        let fullHeight = UserDefaults.standard.float(forKey: SPLIT_VIEW_CONTROLLER_HEIGHT)
        let fullWidth  = width1 + width2
        
        // 讓寬度固定為整個畫面寬度的1/2, 高度固定為整個畫面高度的2/3
        preferredContentSize = CGSize(width: CGFloat(fullWidth * 0.5), height: CGFloat(fullHeight * 0.667))
        print("width = \(CGFloat(fullWidth * 0.5)), height = \(CGFloat(fullHeight * 0.667))")
    }
    
    private func updateUI() {
        
        cancelButtonView.setTitle("取消", for: .normal)
        finishButtonView.setTitle("完成", for: .normal)
        
        //
        // TableView
        //
        
        tableViewDelegate = GroupDispatchTableViewDelegate(groupDispatchViewController: self, tableView: tableView)
        tableViewDelegate?.registerCell(cellName: GROUP_DISPATCH_TABLE_VIEW_CELL, cellId: GROUP_DISPATCH_TABLE_VIEW_CELL)
        
        tableViewDelegate?.reloadUI()
    }
    
    private func updateDataSource() {
        setSearchTextFieldDataSource()
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免在view上加手勢, 點擊cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
}

// MARK: - Event Methods

extension GroupDispatchViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}