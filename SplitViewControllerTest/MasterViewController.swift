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
    
    // Title Filed
    @IBOutlet weak var dispatcherImage: UIButton!
    @IBOutlet weak var dispatcherName: UILabel!

    // Tab Filed
    @IBOutlet weak var tabLeftIcon: UIImageView!
    @IBOutlet weak var tabRightIcon: UIImageView!
    @IBOutlet weak var tabLeftTitle: UILabel!
    @IBOutlet weak var tabRightTitle: UILabel!
    @IBOutlet weak var tabBottomLeftLine: UIView!
    @IBOutlet weak var tabBottomRightLine: UIView!
    
    // Search Filed
    @IBOutlet weak var searchTextField: UITextField!
    
    // TableView Field
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    fileprivate var tableViewDelegate: MasterViewTableViewDelegate?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateGesture()
        
        tableViewDelegate = MasterViewTableViewDelegate(masterViewController: self, tableView: tableView)
        

        tableViewDelegate?.registerCell(cellName: "GroupMembersTableViewCell", cellId: "GroupMembersTableViewCell")

        self.navigationController?.navigationBar.isHidden = true
        tableViewDelegate?.reloadUI()
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    */
    
    // MARK: - Actions
    
    @IBAction func dispatcherSetting(_ sender: UIButton) {
    }
    
    @IBAction func tabLeftContentButtonPressed(_ sender: UIButton) {
        tabBottomLeftLine.backgroundColor = UIColorFromRGB(rgbValue: 0xBD1E49)
        tabBottomRightLine.backgroundColor = .clear
    }
    
    @IBAction func tabRightContentButtonPressed(_ sender: UIButton) {
        tabBottomLeftLine.backgroundColor = .clear
        tabBottomRightLine.backgroundColor = UIColorFromRGB(rgbValue: 0xBD1E49)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareforsegue is called")
        if segue.identifier == "showDetail" {
            let dVC = segue.destination as? DetailViewController
            if let data = tableViewDelegate?.getData() {
                dVC?.str = data[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
}



// MARK: - Private Methods

extension MasterViewController {
    private func updateUI() {
        tabBottomLeftLine.backgroundColor = .clear
        tabBottomRightLine.backgroundColor = .clear
        
        
        // Title Field
        dispatcherImage.layer.cornerRadius = dispatcherImage.frame.size.width / 2
        dispatcherImage.clipsToBounds = true
        dispatcherImage.backgroundColor = .lightGray
        dispatcherName.text = "調度員"
        
        // Tab Filed
        tabLeftTitle.text = "群組"
        tabRightTitle.text = "聯絡人"
        
        
    }
    
    private func updateGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.cancelsTouchesInView = false // 可以避免cell無法被trigger
        self.view.addGestureRecognizer(tap)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

// MARK: - Event Methods

extension MasterViewController {
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension MasterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
