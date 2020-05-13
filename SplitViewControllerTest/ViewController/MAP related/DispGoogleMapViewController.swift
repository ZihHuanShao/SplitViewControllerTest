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
    
    // MARK: - Properties
    
    fileprivate var isDrag: DragType! // 判斷是拖曳或是建立頂點
    fileprivate var finishCreatingEletorFence = false // 是否完成此次繪製
    fileprivate var myLocationMgr: CLLocationManager! // 向使用者取得定位權限
    fileprivate let googleMgr = GoogleMapsManager.shareInstance
    fileprivate var electrFenceVo: ElectrFenceVo?
    fileprivate var fixLocationFlag = false
    fileprivate var path: GMSMutablePath!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLocationDataSource()
        
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        myLocationMgr.stopUpdatingLocation()
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
        
        if !finishCreatingEletorFence {
            googleMgr.deletePreviousPonint(mapView: mapView)
        }
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
        
        // 至少要畫三個點才能按完成, 若沒有則跳警告
        if !finishCreatingEletorFence {
            if googleMgr.finishAddingVertex(mapView: mapView) {
                updateCreateElectrFenceUI(type: .CREATE_SCOPE)
                
                finishCreatingEletorFence = true
            } else {
                showAlert(title: "請至少繪製三個點", message: "")
            }
        }
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
        
        updateCreateElectrFenceUI(type: .DRAW_SCOPE)
        
        // 放棄此次建立的電子圍籬, 重新繪製
        googleMgr.resetMap(mapView: mapView)
        googleMgr.startAddingVertex()
        finishCreatingEletorFence = false
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
        
        // 取得目前圍籬的所有頂點
        let electrFenceCoordinates = googleMgr.getPoints()
        
        // 把圍籬的頂點資訊傳到下一步設定資訊頁面(名稱,顏色,警告設定等等), 以設定該圍籬的Vo資訊
        NotificationCenter.default.post(
            name: CREATE_ELECTR_FENCE_SETTING_NOTIFY_KEY,
            object: nil,
            userInfo: [CREATE_ELECTR_FENCE_SETTING_USER_KEY: electrFenceCoordinates]
        )
    }

}

// MARK: - Private Methods

extension DispGoogleMapViewController {
    private func updateLocationDataSource() {
        myLocationMgr = CLLocationManager()
        myLocationMgr.delegate = self
        
        // 使用者移動多少距離後會更新座標點(單位為米)
        myLocationMgr.distanceFilter = kCLLocationAccuracyBestForNavigation
        
        // 定位的精確度
        myLocationMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        /*
        // Ref: https://reurl.cc/qdVQzg
        // CLLocationDistance Type
        kCLLocationAccuracyBestForNavigation: 精確度最高，適用於導航的定位
        kCLLocationAccuracyBest: 精確度高
        kCLLocationAccuracyNearestTenMeters: 精確度 10 公尺以內
        kCLLocationAccuracyHundredMeters: 精確度 100 公尺以內
        kCLLocationAccuracyKilometer: 精確度 1 公里以內
        kCLLocationAccuracyThreeKilometers: 精確度 3 公里以內
        */
        
        // 不在此處委派, 移至當點擊「新增電子圍籬」才委派
        //mapView.delegate = self
    }
    
    private func updateUI() {
        createButton.setTitle(str_dispGoogleMap_create, for: .normal)
        drawFinishButton.setTitle(str_dispGoogleMap_finish, for: .normal)
    }
    
     private func showAlert(title: String, message: String) {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         
         alert.addAction(okAction)
         present(alert, animated: true, completion: nil)
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
    
    private func updateCreateElectrFenceUI(type: CreateElectrFenceType) {
        
        hintView.isHidden = false
        
        switch type {
        
        // 框選範圍
        case .DRAW_SCOPE:
            drawBackButtonView.isHidden = false
            deleteButtonView.isHidden = true
            drawFinishButtonView.isHidden = false
            createButtonView.isHidden = true
            
            hintTitle.text = str_dispGoogleMap_drawScope
            hintDesc.text = str_dispGoogleMap_drawScopeDesc
            
        // 建立圍籬
        case .CREATE_SCOPE:
            drawBackButtonView.isHidden = true
            deleteButtonView.isHidden = false
            drawFinishButtonView.isHidden = true
            createButtonView.isHidden = false
            
            hintTitle.text = str_dispGoogleMap_createFence
            hintDesc.text = str_dispGoogleMap_createFenceDesc
        }
    }
    
    private func focusOnElectrFence(coordinates: [CLLocationCoordinate2D]) {
        // 讓地圖一出現時不要移動到目前自己的位置
        fixLocationFlag = true
        
        path = GMSMutablePath()
        for coordinate in coordinates {
            path.add(coordinate)
        }
        var bounds: GMSCoordinateBounds = GMSCoordinateBounds()
        for index in 0 ..< path.count() {
            bounds = bounds.includingCoordinate(path.coordinate(at: index))
        }
        
        mapView.animate(with: GMSCameraUpdate.fit(bounds))
        mapView.animate(toZoom: 15)
    }
}

// MARK: - Public Methods

extension DispGoogleMapViewController {
    
    func updateElectrFenceVo(_ electrFenceVo: ElectrFenceVo?) {
        self.electrFenceVo = electrFenceVo
    }
    
    func reloadGoogleMap(type: ShowMapSegueType) {
        switch type {
        
        // 地圖首頁
        case .MAP:
            hintView.isHidden = true
            
        // 電子圍籬
        case .ELECTR_FENCE:
            hintView.isHidden = true
            
        // 電子圍籬中的「新增電子圍籬」
        case .CREATE_ELECTR_FENCE:
            updateCreateElectrFenceUI(type: .DRAW_SCOPE)
            
            // 委派mapView.delegate, 讓user可以在地圖上畫圍籬
            mapView.delegate = self
            
            googleMgr.resetMap(mapView: mapView)
            googleMgr.startAddingVertex()
        
        // 點擊「編輯圍籬範圍」
        case .EDIT_FENCE_SCOPE:
            hintView.isHidden = true
            
            // [顯示圍籬地圖]
            mapView.delegate = self
            googleMgr.resetMap(mapView: mapView)
            
            if let eFenceVo = electrFenceVo, let coordinates = eFenceVo.coordinates, let color = eFenceVo.color {
                
                focusOnElectrFence(coordinates: coordinates)
                
                googleMgr.editPoints(coordinates: coordinates, forTrack: mapView)
                googleMgr.setColor(color)
                googleMgr.dragPoint(true)
            }
            
        // 建立完新的電子圍籬之後
        case .AFTER_CREATE_ELECTR_FENCE:
            hintView.isHidden = true
            
            // [顯示圍籬地圖]
            mapView.delegate = self
            googleMgr.resetMap(mapView: mapView)
            
            if let eFenceVo = electrFenceVo, let coordinates = eFenceVo.coordinates, let color = eFenceVo.color {
                
                focusOnElectrFence(coordinates: coordinates)
                
                googleMgr.editPoints(coordinates: coordinates, forTrack: mapView)
                googleMgr.setColor(color)
                googleMgr.dragPoint(false)
            }
        
        // 即時定位
        case .REAL_TIME_POSITION:
            hintView.isHidden = true
            
        // 臨時群組
        case .TEMPORARY_GROUP:
            hintView.isHidden = true
            
            
        case .EDIT_ELECTR_FENCE, .NONE:
            // no use here
            break
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension DispGoogleMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       
        switch status {
        // 第一次啟用APP
        case .notDetermined:
            myLocationMgr.requestWhenInUseAuthorization()
            
        case .denied:
            let alertController = UIAlertController(title: "定位權限已關閉", message:"如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        
        case .authorizedWhenInUse:
            if !fixLocationFlag {
                myLocationMgr.startUpdatingLocation() // 將畫面移動到目前使用者的位置
                fixLocationFlag = false
            }
            mapView.isMyLocationEnabled = true  // 開啟我的位置(小藍點)
            mapView.settings.myLocationButton = true // 開啟定位按鈕(右下角的圓點)
            
        default:
            break
        }
    }
    
    // 所在位置只要有更動就會觸發
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            
            // 印出目前所在位置座標
            print("[Current Location]: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            // 將視角切換至使用者當前的位置
            let myPos = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 15)
            mapView.animate(to: myPos)

            // 避免自己位置一有變動, 畫面就強制移到定位點
            myLocationMgr.stopUpdatingLocation()
        }
    }
}

// MARK: - GMSMapViewDelegate

extension DispGoogleMapViewController: GMSMapViewDelegate {
    
    // 長按
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let newCoordinate = coordinate
        print("[didLongPressAt]: \(coordinate)")
        
        // 多邊形已畫完
        if googleMgr.checkFinishDrawing() {
            isDrag = .dragWithFinishDrawing
        }
        // 多邊形未畫完
        else {
            // 拖曳
            if isDrag == .dragWithoutFinishingDrawing {
                isDrag = .dragWithKeepDrawing
            }
            // 非拖曳(建立新點)
            else {
                print("[New Point] lat: \(newCoordinate.latitude), lng: \(newCoordinate.longitude)")
                googleMgr.newPoint(coordinate: newCoordinate, forPolygon: mapView)
            }
        }
    }
    
    // NOTE: 偵測「拖曳」與「長按」的function call有不同的順序, 因此另外使用DragType來判斷拖曳點的狀態
    // 1. didBeginDragging -> didLongPressAt -> didDrag -> didEndDragging
    // 2. didBeginDragging -> didDrag -> didEndDragging
    
    // 開始拖曳
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("[didBeginDragging]: \(marker.position)")
        
        // 多邊形未畫完, isDrag設為dragNotFinishDrawingYet
        if !googleMgr.checkFinishDrawing() {
            isDrag = .dragWithoutFinishingDrawing
        }
    }
    
    // 拖曳中
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("[didDrag]: \(marker.position)")
        
        googleMgr.modifyPoint(newMarker: marker, mapView: mapView)
        
        /*---
        if googleMgr.checkFinishDrawing() {
            // 多邊形已畫完
        } else {
            // 多邊形未畫完
        }
        ---*/
        
    }
    
    // 結束拖曳
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("[didEndDragging]: \(marker.position)")
        
        if googleMgr.checkFinishDrawing() {
            isDrag = .dragWithFinishDrawing
        } else {
            isDrag = .dragWithoutFinishingDrawing
        }
    }
}
