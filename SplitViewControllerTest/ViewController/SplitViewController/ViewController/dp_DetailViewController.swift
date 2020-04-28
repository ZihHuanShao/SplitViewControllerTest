//
//  dp_DetailViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

class dp_DetailViewController: UIViewController {

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
    
    fileprivate var collectionViewDelegate: dp_DetailViewCollectionViewDelegate?
    
    // [PTT related]
    
    // 目前所點擊的類型 (群組/ 群組中的「建立群組」/ 聯絡人)
    fileprivate var pttTapType = ShowPttSegueType.NONE
    
    fileprivate var groupVo:  GroupVo?
    
    fileprivate var memberVo: MemberVo?
    
    // [MAP related]
    
    // 目前所點擊的類型 (電子圍籬中的新增電子圍籬/ )
    fileprivate var mapTapType = ShowMapSegueType.NONE
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 取得MainMenu的icon資訊
        reloadMainMenuData()
        
        //
        // Main menu
        //
        
        collectionViewDelegate = dp_DetailViewCollectionViewDelegate(dp_detailViewController: self, collectionView: collectionView)
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

extension dp_DetailViewController {
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
}

// MARK: - Private Methods

extension dp_DetailViewController {
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
            let dp_groupViewController = UIStoryboard(name: STORYBOARD_NAME_DP_GROUP, bundle: nil).instantiateViewController(withIdentifier: "dp_GroupViewController") as! dp_GroupViewController
            
            if let _groupVo = groupVo {
                dp_groupViewController.updateGroupVo(_groupVo)
            }
            setChildView(viewController: dp_groupViewController)
            
        case .TAB_MEMBER_SELECT:
            let dp_memberViewController = UIStoryboard(name: STORYBOARD_NAME_DP_MEMBER, bundle: nil).instantiateViewController(withIdentifier: "dp_MemberViewController") as! dp_MemberViewController
            
            if let _memberVo = memberVo {
                dp_memberViewController.updateMemberVo(_memberVo)
            }
            setChildView(viewController: dp_memberViewController)
        
        case .TAB_GROUP_CREATE_GROUP:
            let dp_createGroupViewController = UIStoryboard(name: STORYBOARD_NAME_DP_GROUP, bundle: nil).instantiateViewController(withIdentifier: "dp_CreateGroupViewController") as! dp_CreateGroupViewController
            
            setChildView(viewController: dp_createGroupViewController)
            
        case .NONE:
            break
        }
    }
    
    private func showMapView() {
        switch mapTapType {
    
        case .MAP_SELECT:
            let dp_googleMapViewController = UIStoryboard(name: STORYBOARD_NAME_DP_MAP, bundle: nil).instantiateViewController(withIdentifier: "dp_GoogleMapViewController") as! dp_GoogleMapViewController
            
            setChildView(viewController: dp_googleMapViewController)
            
        case .EDIT_MAP_SELECT:
            let dp_editElectrFenceViewController = UIStoryboard(name: STORYBOARD_NAME_DP_MAP, bundle: nil).instantiateViewController(withIdentifier: "dp_EditElectrFenceViewController") as! dp_EditElectrFenceViewController
            
            setChildView(viewController: dp_editElectrFenceViewController)
            
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
                let dp_groupViewController = viewController as! dp_GroupViewController
                self.addChild(dp_groupViewController)
                dp_groupViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dp_groupViewController.view)
                
                dp_groupViewController.didMove(toParent: self)
                
            case .TAB_MEMBER_SELECT:
                let dp_memberViewController = viewController as! dp_MemberViewController
                self.addChild(dp_memberViewController)
                dp_memberViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dp_memberViewController.view)
                
                dp_memberViewController.didMove(toParent: self)
            
            case .TAB_GROUP_CREATE_GROUP:
                let dp_createGroupViewController = viewController as! dp_CreateGroupViewController
                self.addChild(dp_createGroupViewController)
                dp_createGroupViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dp_createGroupViewController.view)
                
                dp_createGroupViewController.didMove(toParent: self)
                break
                
            case .NONE:
                break
            }
            
        case .MAP:
            switch mapTapType {
                
            case .MAP_SELECT:
                let dp_googleMapViewController = viewController as! dp_GoogleMapViewController
                self.addChild(dp_googleMapViewController)
                dp_googleMapViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dp_googleMapViewController.view)
                
                dp_googleMapViewController.didMove(toParent: self)
                
            case .EDIT_MAP_SELECT:
                let dp_editElectrFenceViewController = viewController as! dp_EditElectrFenceViewController
                self.addChild(dp_editElectrFenceViewController)
                dp_editElectrFenceViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(dp_editElectrFenceViewController.view)
                
                dp_editElectrFenceViewController.didMove(toParent: self)
                
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
