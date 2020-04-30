//
//  DispGoogleMapViewController.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/20.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps


class DispGoogleMapViewController: UIViewController {

    // MARK: - IBOutlet
    

    @IBOutlet weak var mapView: GMSMapView!
    
    // [Hint View]
    
    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var hintTitle: UILabel!
    @IBOutlet weak var hintDesc: UILabel!
    
    @IBOutlet weak var drawBackButtonView: UIView! // 返回上一步
    @IBOutlet weak var drawBackButtonBackgroundImage: UIImageView!
    
    @IBOutlet weak var drawFinishButtonView: UIView! // 完成
    @IBOutlet weak var drawFinishButtonBackgroundImage: UIImageView!
    @IBOutlet weak var drawFinishButton: UIButton!
    
    
    @IBOutlet weak var deleteButtonView: UIView! // 放棄
    @IBOutlet weak var deleteButtonBackgroundImage: UIImageView!
    
    @IBOutlet weak var createButtonView: UIView! // 建立
    @IBOutlet weak var createButtonBackgroundImage: UIImageView!
    @IBOutlet weak var createButton: UIButton!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        mapView.camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView

        updateUI()
    }
    
    // MARK: - Actions
    
    // [drawBackButton] 返回上一步
    
    @IBAction func drawBackButtonTouchDown(_ sender: UIButton) {
        updateDrawBackButtonImage(type: .PRESSED)
    }
    
    @IBAction func drawBackButtonTouchDragExit(_ sender: UIButton) {
        updateDrawBackButtonImage(type: .AWAY)
    }
    
    @IBAction func drawBackButtonTouchUpInside(_ sender: UIButton) {
        updateDrawBackButtonImage(type: .AWAY)
    }
    
    // [drawFinishButton] 完成
    
    @IBAction func drawFinishButtonTouchDown(_ sender: UIButton) {
        updateDrawFinishButtonImage(type: .PRESSED)
    }
    
    @IBAction func drawFinishButtonTouchDragExit(_ sender: UIButton) {
        updateDrawFinishButtonImage(type: .AWAY)
    }
    
    @IBAction func drawFinishButtonTouchUpInside(_ sender: UIButton) {
        updateDrawFinishButtonImage(type: .AWAY)
    }
    
    // [deleteButton] 放棄
    
    @IBAction func deleteButtonTouchDown(_ sender: UIButton) {
        updateDeleteButtonImage(type: .PRESSED)
    }
    
    @IBAction func deleteButtonTouchDragExit(_ sender: UIButton) {
        updateDeleteButtonImage(type: .AWAY)
    }
    
    @IBAction func deleteButtonTouchUpInside(_ sender: UIButton) {
        updateDeleteButtonImage(type: .AWAY)
    }
    
    // [createButton] 建立
    
    @IBAction func createButtonTouchDown(_ sender: UIButton) {
        updateCreateButtonImage(type: .PRESSED)
    }
    
    @IBAction func createButtonTouchDragExit(_ sender: UIButton) {
        updateCreateButtonImage(type: .AWAY)
    }
    
    @IBAction func createButtonTouchUpInside(_ sender: UIButton) {
        updateCreateButtonImage(type: .AWAY)
    }

}

// MARK: - Private Methods

extension DispGoogleMapViewController {
    
    private func updateUI() {
        createButton.setTitle(str_dispGoogleMap_create, for: .normal)
        drawFinishButton.setTitle(str_dispGoogleMap_finish, for: .normal)
    }
    
    private func updateDrawBackButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            drawBackButtonBackgroundImage.image = UIImage(named: "btn_back_pressed")
            
        case .AWAY:
            drawBackButtonBackgroundImage.image = UIImage(named: "btn_back_normal")
        }
    }
    
    private func updateDrawFinishButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            drawFinishButtonBackgroundImage.image = UIImage(named: "btn_text_pressed")
            
        case .AWAY:
            drawFinishButtonBackgroundImage.image = UIImage(named: "btn_text_normal")
        }
    }
    
    private func updateDeleteButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            deleteButtonBackgroundImage.image = UIImage(named: "btn_delete_pressed")
            
        case .AWAY:
            deleteButtonBackgroundImage.image = UIImage(named: "btn_delete_normal")
        }
    }
    
    private func updateCreateButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            createButtonBackgroundImage.image = UIImage(named: "btn_text_pressed")
            
        case .AWAY:
            createButtonBackgroundImage.image = UIImage(named: "btn_text_normal")
        }
    }
    

}

// MARK: - Public Methods

extension DispGoogleMapViewController {
    func reloadGoogleMap(type: ShowMapSegueType) {
        switch type {
            
        case .MAP:
            hintView.isHidden = true
            break
            
        case .ELECTR_FENCE:
            hintView.isHidden = true
            break
            
        case .CREATE_ELECTR_FENCE:
            hintView.isHidden = false
            break

        case .REAL_TIME_POSITION:
            hintView.isHidden = true
            break
            
        case .TEMPORARY_GROUP:
            hintView.isHidden = true
            break
            
        case .EDIT_ELECTR_FENCE, .NONE:
            // no use here
            break
        }
    }
}
