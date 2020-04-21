//
//  ElectrFenceViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/21.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class ElectrFenceViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var tableViewDelegate: ElectrFenceViewControllerTableViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDataSource()
        updateUI()
    }
    
    @IBAction func backButtonTouchDown(_ sender: UIButton) {
    }
    @IBAction func backButtonTouchDragExit(_ sender: UIButton) {
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
        super.navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ElectrFenceViewController {
    private func updateDataSource() {
        tableViewDelegate = ElectrFenceViewControllerTableViewDelegate(electrFenceViewController: self, tableView: tableView)
    }
    
    private func updateUI() {
        tableViewDelegate?.reloadUI()
    }
}
