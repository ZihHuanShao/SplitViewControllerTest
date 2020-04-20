//
//  DetailViewController.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/24.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import UIKit

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
    
    // 目前所點擊的類型 (群組/ 群組中的建立群組/ 聯絡人)
    fileprivate var tapType = ShowDetailViewControllerType.NONE
    
    fileprivate var groupVo:  GroupVo?
    
    fileprivate var memberVo: MemberVo?
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 取得MainMenu的icon資訊
        reloadMainMenuData()
        
        //
        // Main menu
        //
        
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
    
    func setTabSelected(type: ShowDetailViewControllerType) {
        tapType = type
    }
    
    func setMainMenuType(_ mainMenuType: MainMenuType) {
        self.mainMenuType = mainMenuType
    }
    
    func setMainMenuSelectedRowIndex(_ rowIndex: Int) {
        mainMenuSelectedRowIndex = rowIndex
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
        switch tapType {
        case .TAB_GROUP_SELECT:
            let groupViewController = UIStoryboard(name: STORYBOARD_NAME_GROUP, bundle: nil).instantiateViewController(withIdentifier: "GroupViewController") as! GroupViewController
            
            if let _groupVo = groupVo {
                groupViewController.updateGroupVo(_groupVo)
            }
            setChildView(viewController: groupViewController)
            
        case .TAB_MEMBER_SELECT:
            let memberViewController = UIStoryboard(name: STORYBOARD_NAME_MEMBER, bundle: nil).instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
            
            if let _memberVo = memberVo {
                memberViewController.updateMemberVo(_memberVo)
            }
            setChildView(viewController: memberViewController)
        
        case .TAB_GROUP_CREATE_GROUP:
            let createGroupViewController = UIStoryboard(name: STORYBOARD_NAME_GROUP, bundle: nil).instantiateViewController(withIdentifier: "CreateGroupViewController") as! CreateGroupViewController
            
            setChildView(viewController: createGroupViewController)
            
        case .NONE:
            break
        }
    }
    
    private func showMapView() {
        let mapFenceViewController = UIStoryboard(name: STORYBOARD_NAME_MAP, bundle: nil).instantiateViewController(withIdentifier: "MapFenceViewController") as! MapFenceViewController
        
        setChildView(viewController: mapFenceViewController)
    }
    
    private func showVideoView() {
        
    }
    
    private func showRecordView() {
        
    }
    
    private func setChildView(viewController: UIViewController) {
        switch self.mainMenuType {
        case .PTT:
            switch tapType {
            case .TAB_GROUP_SELECT:
                let groupViewController = viewController as! GroupViewController
                self.addChild(groupViewController)
                groupViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(groupViewController.view)
                
                groupViewController.didMove(toParent: self)
                
            case .TAB_MEMBER_SELECT:
                let memberViewController = viewController as! MemberViewController
                self.addChild(memberViewController)
                memberViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(memberViewController.view)
                
                memberViewController.didMove(toParent: self)
            
            case .TAB_GROUP_CREATE_GROUP:
                let createGroupViewController = viewController as! CreateGroupViewController
                self.addChild(createGroupViewController)
                createGroupViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
                self.containerView.addSubview(createGroupViewController.view)
                
                createGroupViewController.didMove(toParent: self)
                break
                
            case .NONE:
                break
            }
            
        case .MAP:
            let mapFenceViewController = viewController as! MapFenceViewController
            self.addChild(mapFenceViewController)
            mapFenceViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
            self.containerView.addSubview(mapFenceViewController.view)
            
            mapFenceViewController.didMove(toParent: self)
            
        case .VIDEO:
            break
            
        case .RECORD:
            break
            
        case .NONE:
            break
        }
        
    }
}
