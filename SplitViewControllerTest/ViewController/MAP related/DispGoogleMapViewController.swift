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
    
    @IBOutlet weak var toolButtonImage: UIImageView!
    @IBOutlet weak var addButtonImage: UIImageView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
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

    }
    
    @IBAction func toolButtonTouchDown(_ sender: UIButton) {
        updateToolButtonImage(type: .PRESSED)
    }
    
    @IBAction func toolButtonTouchDragExit(_ sender: UIButton) {
        updateToolButtonImage(type: .AWAY)
    }
    
    @IBAction func toolButtonTiuchUpInside(_ sender: UIButton) {
        updateToolButtonImage(type: .AWAY)
    }
    
    @IBAction func addButtonTouchDown(_ sender: UIButton) {
        updateAddButtonImage(type: .PRESSED)
    }
    
    @IBAction func addButtonTouchDragExit(_ sender: UIButton) {
        updateAddButtonImage(type: .AWAY)
    }
    
    @IBAction func addButtonTiuchUpInside(_ sender: UIButton) {
        updateAddButtonImage(type: .AWAY)
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

extension DispGoogleMapViewController {
    private func updateToolButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            toolButtonImage.image = UIImage(named: "btn_tool_pressed")
            
        case .AWAY:
            toolButtonImage.image = UIImage(named: "btn_tool_normal")
        }
    }
    
    private func updateAddButtonImage(type: ButtonPressType) {
        switch type {
        case .PRESSED:
            addButtonImage.image = UIImage(named: "btn_add_pressed")
            
        case .AWAY:
            addButtonImage.image = UIImage(named: "btn_add_normal")
        }
    }
}
