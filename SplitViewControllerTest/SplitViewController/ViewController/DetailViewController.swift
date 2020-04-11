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
    
    fileprivate var tabSelected = TabType.NONE
    
    fileprivate var groupVo:  GroupVo?
    fileprivate var memberVo: MemberVo?
    
    // Delegate
    fileprivate var collectionViewDelegate: DetailViewCollectionViewDelegate?
    
    fileprivate var mainMenuIconsVo = [MainMenuIconVo]()
    
    let mainMenuIcons = [
        MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_PTT[0], unselectedIcon: MAIN_MENU_ICON_PTT[1]),
        MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_MAP[0], unselectedIcon: MAIN_MENU_ICON_MAP[1]),
        MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_VIDEO[0], unselectedIcon: MAIN_MENU_ICON_VIDEO[1]),
        MainMenuIconInfo(selectedIcon: MAIN_MENU_ICON_HISTORY[0], unselectedIcon: MAIN_MENU_ICON_HISTORY[1])
    ]
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTestData()
        
        // Main menu
        collectionViewDelegate = DetailViewCollectionViewDelegate(detailViewController: self, collectionView: collectionView)
        collectionViewDelegate?.updateMainMenuIcons(mainMenuIconsVo: mainMenuIconsVo)
        collectionViewDelegate?.reloadUI()
        
        switch tabSelected {
            
        case .GROUP:
            let groupVC = UIStoryboard(name: STORYBOARD_NAME_GROUP, bundle: nil).instantiateViewController(withIdentifier: "GroupViewController") as! GroupViewController
            
            if let _groupVo = groupVo {
                groupVC.setGroupName(name: _groupVo.name ?? "")
                groupVC.setGroupNumber(_groupVo.count ?? 0)
                if _groupVo.notifyState {
                    groupVC.setMonitorImageName(name: "icon_titile_notify_on")
                } else {
                    groupVC.setMonitorImageName(name: "icon_titile_notify_off")
                }
            }

            
            self.addChild(groupVC)
            groupVC.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
            self.containerView.addSubview(groupVC.view)
            
            groupVC.didMove(toParent: self)
        
        case .MEMBER:
            let memberVC = UIStoryboard(name: STORYBOARD_NAME_MEMBER, bundle: nil).instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
            
            if let _memberVo = memberVo {
                    memberVC.setMemberName(name: _memberVo.name ?? "")
                    memberVC.setMemberImage(name: _memberVo.imageName ?? "")
            }
            
            self.addChild(memberVC)
            memberVC.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
            self.containerView.addSubview(memberVC.view)
            
            memberVC.didMove(toParent: self)
        
        case .NONE:
            break
        }
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
    
    func setTabSelected(type: TabType) {
        tabSelected = type
    }
}

// MARK: - Private Methods

extension DetailViewController {
    private func reloadTestData() {
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
}
