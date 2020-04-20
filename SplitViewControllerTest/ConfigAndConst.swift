//
//  ConfigAndConst.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit

// MainMenuIcon [點擊時,未點擊時]
let MAIN_MENU_ICON_PTT     = ["btn_menu_ptt_selected", "btn_menu_ptt_normal"]
let MAIN_MENU_ICON_MAP     = ["btn_menu_map_selected", "btn_menu_map_normal"]
let MAIN_MENU_ICON_VIDEO   = ["btn_menu_video_selected", "btn_menu_video_normal"]
let MAIN_MENU_ICON_HISTORY = ["btn_menu_history_selected", "btn_menu_history_normal"]

// PTT動畫
let PTT_ANIMATION_IMAGES: [UIImage] = [UIImage(named: "bg_ptt_animation1")!,
                                       UIImage(named: "bg_ptt_animation2")!,
                                       UIImage(named: "bg_ptt_animation3")!,
                                       UIImage(named: "bg_ptt_animation4")!,
                                       UIImage(named: "bg_ptt_animation5")!,
                                       UIImage(named: "bg_ptt_animation6")!,
                                       UIImage(named: "bg_ptt_animation7")!,
                                       UIImage(named: "bg_ptt_animation8")!,
                                       UIImage(named: "bg_ptt_animation9")!]

// 接收PTT聲波動畫
let PTT_SOUND_WAVE_ANIMATION_IMAGES: [UIImage] = [UIImage(named: "icon_voice_animation1")!,
                                                  UIImage(named: "icon_voice_animation2")!,
                                                  UIImage(named: "icon_voice_animation3")!,
                                                  UIImage(named: "icon_voice_animation4")!]

// 聯絡人資訊
let MEMBER_PROFILE_TITLES = [str_memberProfile_userId,
                             str_memberProfile_sipId,
                             str_memberProfile_country,
                             str_memberProfile_email]

// Storyboard(ViewController) ID
let ADD_MEMBER_VIEW_CONTROLLER = "AddMemberViewController"
let GROUP_DISPATCH_VIEW_CONTROLLER = "GroupDispatchViewController"

// Segue
let SHOW_DETAIL_VIEW_CONTROLLER = "showDetailViewController"
let SHOW_MAP_SEGUE = "showMapSegue"

// Cell
let GROUP_TABLE_VIEW_CELL  = "GroupTableViewCell"  // nib name & cell name (the same)
let MEMBER_TABLE_VIEW_CELL = "MemberTableViewCell" // nib name & cell name (the same)
let MAINMENU_COLLECTION_VIEW_CELL = "MainMenuCollectionViewCell"
let GROUP_COLLECTION_VIEW_CELL = "GroupCollectionViewCell"
let MEMBER_PROFILE_TABLE_VIEW_CELL = "MemberProfileTableViewCell"
let GROUP_DISPATCH_TABLE_VIEW_CELL = "GroupDispatchTableViewCell"
let GROUP_DISPATCH_COLLECTION_VIEW_CELL = "GroupDispatchCollectionViewCell"
let CREATE_GROUP_TABLE_VIEW_CELL = "CreateGroupTableViewCell"
let ADD_MEMBER_TABLE_VIEW_CELL = "AddMemberTableViewCell"
let ADD_MEMBER_COLLECTION_VIEW_CELL = "AddMemberCollectionViewCell"

// Storyboard
let STORYBOARD_NAME_MAIN   = "Main"
let STORYBOARD_NAME_MEMBER = "Member"
let STORYBOARD_NAME_GROUP  = "Group"
let STORYBOARD_NAME_MAP    = "Map"

// UserDefault
let SPLIT_MASTER_VIEW_CONTROLLER_WIDTH = "splitMasterViewControllerWidth"
let SPLIT_DETAIL_VIEW_CONTROLLER_WIDTH = "splitDetailViewControllerWidth"
let SPLIT_VIEW_CONTROLLER_HEIGHT       = "splitViewControllerHeight"

// Notification
let DROP_SELECTED_GROUP_TABLE_CELL_NOTIFY_KEY = NSNotification.Name(rawValue: "dropSelectedGroupTableCellNotifyKey")
let DROP_SELECTED_MEMBER_TABLE_CELL_NOTIFY_KEY = NSNotification.Name(rawValue: "dropSelectedMemberTableCellNotifyKey")
let CHANGE_MONITOR_NOTIFY_KEY = NSNotification.Name(rawValue: "changeMonitorNotifyKey")
let SELECTED_MEMBERS_RELOADED_NOTIFY_KEY = NSNotification.Name(rawValue: "selectedMembersReloadedNotifyKey")
let KEEP_ORIGINAL_SPLIT_VIEW_CONTROLLER_NOTIFY_KEY = NSNotification.Name("keepOriginalSplitViewControllerNotifyKey")
let RELOAD_GROUP_TABLE_VIEW_NOTIFY_KEY = Notification.Name("reloadGroupTableViewObserverNotifyKey")
let SWITCH_MAIN_MENU_NOTIFY_KEY = Notification.Name("switchMainMenuNotifyKey")

// Notification userInfo
let DROP_SELECTED_GROUP_TABLE_CELL_USER_KEY = "dropSelectedGroupTableCellUserKey"
let DROP_SELECTED_Member_TABLE_CELL_USER_KEY = "dropSelectedMemberTableCellUserKey"
let CHANGE_MONITOR_USER_KEY = "changeMonitorUserKey"
let SELECTED_MEMBERS_RELOADED_USER_KEY = "selectedMembersReloadedUserKey"
let KEEP_ORIGINAL_SPLIT_VIEW_CONTROLLER_USER_KEY = "keepOriginalSplitViewControllerUserKey"
let RELOAD_GROUP_TABLE_VIEW_USER_KEY = "reloadGroupTableViewObserverUserKey"
let SWITCH_MAIN_MENU_USER_KEY = "switchMainMenuUserKey"

// 通訊錄Tab
let TAB_BOTTOM_LINE_COLOR      = 0xE94242 // 底線色碼
let TAB_SELECTED_TITLE_COLOR   = 0xE94242 // 已選文字色碼
let TAB_UNSELECTED_TITLE_COLOR = 0x9F9A94 // 未選文字色碼


// enum
enum MainMenuType: Int {
    case PTT    = 0
    case MAP    = 1
    case VIDEO  = 2
    case RECORD = 3
    case NONE   = 99
}

enum ShowDetailViewControllerType: Int {
    case TAB_GROUP_SELECT  = 0
    case TAB_MEMBER_SELECT = 1
    case TAB_GROUP_CREATE_GROUP = 2
    
    case NONE = 99
}

enum TabType: Int {
    case GROUP  = 0
    case MEMBER = 1
    case NONE   = 2
}

enum OnlineType: Int {
    case AVAILABLE  = 0
    case BUSY       = 1
    case NO_DISTURB = 2
    case OFFLINE    = 3
}

enum MemberProfileType: CaseIterable {
    case USER_ID
    case SIP_NUMBER
    case COUNTRY
    case EMAIL
}

enum ButtonPressType: Int {
    case PRESSED = 0
    case AWAY    = 1
}

// struct
struct GroupInfo {
    var name: String?
    var count: Int?
    var imageName: String?
    var desc: String?
    var monitorState = Bool()
    var isSelected = Bool()
}

struct MemberInfo {
    var name: String?
    var imageName: String?
    var userId: String?
    var sipId: String?
    var country: String?
    var email: String?
    var onlineState = OnlineType.OFFLINE
    var isSelected = Bool()
}

struct MainMenuIconInfo {
    var selectedIcon: String?
    var unselectedIcon: String?
}

struct SwitchMainMenuUserInfo {
    var mainMenuType = MainMenuType.NONE
    var selectedRowIndex: Int?
}

struct UnderlayPresentInfo {
    var backgroundImageView: UIImageView?
    var window: UIWindow?
    var groupsVo: [GroupVo]?
}
