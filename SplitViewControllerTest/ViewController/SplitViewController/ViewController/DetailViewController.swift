//
//  DetailViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    
    // [Common used]
    
    // 目前所點擊的menu
    fileprivate var mainMenuType = MainMenuType.NONE
    
    // 目前所點擊menu的collectionView row index
    fileprivate var mainMenuSelectedRowIndex: Int?
    
    fileprivate var mainMenuIconsVo = [MainMenuIconVo]()
    
    fileprivate var collectionViewDelegate: DetailViewCollectionViewDelegate?
    
    // [PTT related]
    
    // 目前所點擊的類型 (群組/ 群組中的「建立群組」/ 聯絡人)
    fileprivate var pttTapType = ShowPttSegueType.NONE
    
    fileprivate var groupVo:  GroupVo?
    
    fileprivate var memberVo: MemberVo?
    
    // [MAP related]
    
    // 目前所點擊的類型 (目前僅分為是否顯示地圖兩種)
    fileprivate var mapTapType = ShowMapSegueType.NONE
    fileprivate var editElectrFenceDisplayType = EditElectrFenceDisplayType.NONE
    fileprivate var newElectrFenceCoordinates: [CLLocationCoordinate2D]?
    fileprivate var electrFenceVo: ElectrFenceVo?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 取得MainMenu的icon資訊
        reloadMainMenuData()
        
        // [Main menu]
        
        collectionViewDelegate = DetailViewCollectionViewDelegate(detailViewController: self, collectionView: collectionView)
        collectionViewDelegate?.updateMainMenuIcons(mainMenuIconsVo: mainMenuIconsVo)
        
        // show PTT menu color
        /* 禁止使用呼叫didSelectItemAt造成無窮迴圈
        collectionViewDelegate?.collectionView(collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        */
        
        // 已點擊MainMenu的其中一項
        if let rowIndex = mainMenuSelectedRowIndex {
            collectionViewDelegate?.setBackgroundColor(rowIndex)
        }
        // MainMenu預設顯示點擊PTT Menu
        else {
            collectionViewDelegate?.setBackgroundColor(0)
        }
        
        collectionViewDelegate?.reloadUI()
        
        showCurrentView(mainMenuType: self.mainMenuType)

    }
}

// MARK: - Public Methods

extension DetailViewController {
    func updateGroup(_ groupVo: GroupVo) {
        self.groupVo = groupVo
    }
    
    func updateMember(_ memberVo: MemberVo) {
        self.memberVo = memberVo
    }
    
    func setPttTabSelected(type: ShowPttSegueType) {
        pttTapType = type
    }
    
    func setMapTabSelected(type: ShowMapSegueType) {
        mapTapType = type
    }
    
    func setMainMenuType(_ mainMenuType: MainMenuType) {
        self.mainMenuType = mainMenuType
    }
    
    func setMainMenuSelectedRowIndex(_ rowIndex: Int) {
        mainMenuSelectedRowIndex = rowIndex
    }
    
    func setEditElectrFenceDisplayType(_ type: EditElectrFenceDisplayType) {
        self.editElectrFenceDisplayType = type
    }
    
    func updateNewElectrFenceCoordinates(_ newElectrFenceCoordinates: [CLLocationCoordinate2D]?) {
        self.newElectrFenceCoordinates = newElectrFenceCoordinates
    }
    
    func updateElectrFenceVo(_ electrFenceVo: ElectrFenceVo?) {
        self.electrFenceVo = electrFenceVo
    }
}

// MARK: - Private Methods

extension DetailViewController {
    private func reloadMainMenuData() {
        let mainMenuIcons = [
            MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_PTT[0], unselectedIcon: MAIN_MENU_ICON_PTT[1]),
            MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_MAP[0], unselectedIcon: MAIN_MENU_ICON_MAP[1]),
            MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_VIDEO[0], unselectedIcon: MAIN_MENU_ICON_VIDEO[1]),
            MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_HISTORY[0], unselectedIcon: MAIN_MENU_ICON_HISTORY[1])
        ]
        
        for mainMenuIcon in mainMenuIcons {
            mainMenuIconsVo.append(
                MainMenuIconVo(
                    selectedIconName: mainMenuIcon.selectedIcon,
                    unselectedIconName: mainMenuIcon.unselectedIcon,
                    isSelected: false
                )
            )
        }
    }
    
    private func showCurrentView(mainMenuType: MainMenuType) {
        switch mainMenuType {
            
        case .PTT:
            showPttView()
            
        case .MAP:
            showMapView()
            
        case .VIDEO:
            showVideoView()
            
        case .RECORD:
            showRecordView()
            
        case .NONE:
            break
        }
    }
    
    private func showPttView() {
        switch pttTapType {
        case .TAB_GROUP_SELECT:
            let dispGroupViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_GROUP, bundle: nil).instantiateViewController(withIdentifier: "DispGroupViewController") as! DispGroupViewController
            
            if let _groupVo = groupVo {
                dispGroupViewController.updateGroupVo(_groupVo)
            }
            setChildView(viewController: dispGroupViewController)
            
        case .TAB_MEMBER_SELECT:
            let dispMemberViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MEMBER, bundle: nil).instantiateViewController(withIdentifier: "DispMemberViewController") as! DispMemberViewController
            
            if let _memberVo = memberVo {
                dispMemberViewController.updateMemberVo(_memberVo)
            }
            setChildView(viewController: dispMemberViewController)
        
        case .TAB_GROUP_CREATE_GROUP:
            let dispCreateGroupViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_GROUP, bundle: nil).instantiateViewController(withIdentifier: "DispCreateGroupViewController") as! DispCreateGroupViewController
            
            setChildView(viewController: dispCreateGroupViewController)
            
        case .NONE:
            break
        }
    }
    
    private func showMapView() {
        switch mapTapType {

        // 地圖首頁
        case .MAP:
            let dispGoogleMapViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispGoogleMapViewController") as! DispGoogleMapViewController
            
            setChildView(viewController: dispGoogleMapViewController)
            dispGoogleMapViewController.reloadGoogleMap(type: .MAP)
        
        // 電子圍籬
        case .ELECTR_FENCE:
            let dispGoogleMapViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispGoogleMapViewController") as! DispGoogleMapViewController
            
            setChildView(viewController: dispGoogleMapViewController)
            dispGoogleMapViewController.reloadGoogleMap(type: .ELECTR_FENCE)
            
        
        // 電子圍籬中的「新增電子圍籬」
        case .CREATE_ELECTR_FENCE:
            let dispGoogleMapViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispGoogleMapViewController") as! DispGoogleMapViewController
            
            setChildView(viewController: dispGoogleMapViewController)
            dispGoogleMapViewController.reloadGoogleMap(type: .CREATE_ELECTR_FENCE)
            
            
        // 電子圍籬中的「設定」, 顯示該頁面有兩種時機:
        // 1. 新增電子圍籬後, 要設定相關圍籬資訊(名稱/顯示顏色/警告設定等等) 2. 針對已存在的電子圍籬做編輯
        case .EDIT_ELECTR_FENCE:
            let dispEditElectrFenceViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispEditElectrFenceViewController") as! DispEditElectrFenceViewController
            
            switch editElectrFenceDisplayType {
                
            case .CREATE:
                dispEditElectrFenceViewController.setDisplayMode(type: .CREATE)
                dispEditElectrFenceViewController.updateNewElectrFenceCoordinates(newElectrFenceCoordinates)
                setChildView(viewController: dispEditElectrFenceViewController)
                
            case .EDIT:
                dispEditElectrFenceViewController.setDisplayMode(type: .EDIT)
                setChildView(viewController: dispEditElectrFenceViewController)
                
            case .NONE:
                break
            }
        
        // 點擊「編輯圍籬範圍」
        case .EDIT_FENCE_SCOPE:
            let dispGoogleMapViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispGoogleMapViewController") as! DispGoogleMapViewController
            
            setChildView(viewController: dispGoogleMapViewController)
            dispGoogleMapViewController.setElectrFenceVo(electrFenceVo)
            dispGoogleMapViewController.reloadGoogleMap(type: .EDIT_FENCE_SCOPE)
        
        // 建立完新的電子圍籬之後
        case .AFTER_CREATE_ELECTR_FENCE:
            let dispGoogleMapViewController = UIStoryboard(name: STORYBOARD_NAME_DISP_MAP, bundle: nil).instantiateViewController(withIdentifier: "DispGoogleMapViewController") as! DispGoogleMapViewController
            
            setChildView(viewController: dispGoogleMapViewController)
            dispGoogleMapViewController.setElectrFenceVo(electrFenceVo)
            dispGoogleMapViewController.reloadGoogleMap(type: .AFTER_CREATE_ELECTR_FENCE)
            
        
        // 即時定位
        case .REAL_TIME_POSITION:
            break
        
        // 臨時群組
        case .TEMPORARY_GROUP:
            break
            
        case .NONE:
            break
        }
        
    }
    
    private func showVideoView() {
        
    }
    
    private func showRecordView() {
        
    }
    
    private func setChildView(viewController: UIViewController) {
        switch self.mainMenuType {
        case .PTT:
            switch pttTapType {
            case .TAB_GROUP_SELECT:
                let dispGroupViewController = viewController as! DispGroupViewController
                self.addChild(dispGroupViewController)
                dispGroupViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dispGroupViewController.view)
                
                dispGroupViewController.didMove(toParent: self)
                
            case .TAB_MEMBER_SELECT:
                let dispMemberViewController = viewController as! DispMemberViewController
                self.addChild(dispMemberViewController)
                dispMemberViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dispMemberViewController.view)
                
                dispMemberViewController.didMove(toParent: self)
            
            case .TAB_GROUP_CREATE_GROUP:
                let dispCreateGroupViewController = viewController as! DispCreateGroupViewController
                self.addChild(dispCreateGroupViewController)
                dispCreateGroupViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dispCreateGroupViewController.view)
                
                dispCreateGroupViewController.didMove(toParent: self)
                break
                
            case .NONE:
                break
            }
            
        case .MAP:
            switch mapTapType {
                
            case .MAP,
                 .ELECTR_FENCE,
                 .CREATE_ELECTR_FENCE,
                 .EDIT_FENCE_SCOPE,
                 .AFTER_CREATE_ELECTR_FENCE:
                
                let dispGoogleMapViewController = viewController as! DispGoogleMapViewController
                self.addChild(dispGoogleMapViewController)
                dispGoogleMapViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dispGoogleMapViewController.view)
                
                dispGoogleMapViewController.didMove(toParent: self)
                
            case .EDIT_ELECTR_FENCE:
                let dispEditElectrFenceViewController = viewController as! DispEditElectrFenceViewController
                self.addChild(dispEditElectrFenceViewController)
                dispEditElectrFenceViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dispEditElectrFenceViewController.view)
                
                dispEditElectrFenceViewController.didMove(toParent: self)
            
            case .REAL_TIME_POSITION:
                break
                
            case .TEMPORARY_GROUP:
                break
                
            case .NONE:
                break
            
            }
            
            
        case .VIDEO:
            break
            
        case .RECORD:
            break
            
        case .NONE:
            break
        }
        
    }
}
