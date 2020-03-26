//
//  MasterViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    fileprivate var tableViewDelegate: MasterViewTableViewDelegate?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView)
        
        tableViewDelegate?.registerCell(cellName: "TitleInfoTableViewCell", cellId: "TitleInfoTableViewCell")
        tableViewDelegate?.registerCell(cellName: "TitleTabTableViewCell", cellId: "TitleTabTableViewCell")
        tableViewDelegate?.registerCell(cellName: "SearchTableViewCell", cellId: "SearchTableViewCell")
        tableViewDelegate?.registerCell(cellName: "GroupMembersTableViewCell", cellId: "GroupMembersTableViewCell")

        self.navigationController?.navigationBar.isHidden = true
        tableViewDelegate?.reloadUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let dVC = segue.destination as? DetailViewController
            if let data = tableViewDelegate?.getData() {
                dVC?.str = data[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
 
    
}

// Event Methods

extension MasterViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}
