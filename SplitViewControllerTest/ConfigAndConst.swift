//
//  ConfigAndConst.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation

// MainMenuIcon [點擊時的圖,未點擊時的圖]
let MAIN_MENU_ICON_PTT     = ["btn_menu_ptt_selected", "btn_menu_ptt_normal"]
let MAIN_MENU_ICON_MAP     = ["btn_menu_map_selected", "btn_menu_map_normal"]
let MAIN_MENU_ICON_VIDEO   = ["btn_menu_video_selected", "btn_menu_video_normal"]
let MAIN_MENU_ICON_HISTORY = ["btn_menu_history_selected", "btn_menu_history_normal"]

//let MAIN_MENU_ICONS_UNSELECTED = [
//    "btn_menu_ptt_normal",
//    "btn_menu_map_normal",
//    "btn_menu_video_normal",
//    "btn_menu_history_normal"
//]
//
//let MAIN_MENU_ICONS_SELECTED = [
//    "btn_menu_ptt_selected",
//    "btn_menu_map_selected",
//    "btn_menu_video_selected",
//    "btn_menu_history_selected"
//]

// Cell
let GROUP_TABLE_VIEW_CELL  = "GroupTableViewCell"  // nib name & cell name (the same)
let MEMBER_TABLE_VIEW_CELL = "MemberTableViewCell" // nib name & cell name (the same)
let MAINMENU_COLLECTION_VIEW_CELL = "MainMenuCollectionViewCell"
let GROUP_COLLECTION_VIEW_CELL = "GroupCollectionViewCell"
let MEMBER_PROFILE_TABLE_VIEW_CELL = "MemberProfileTableViewCell"
let GROUP_DISPATCH_TABLE_VIEW_CELL = "GroupDispatchTableViewCell"
let GROUP_DISPATCH_COLLECTION_VIEW_CELL = "GroupDispatchCollectionViewCell"

// Storyboard
let STORYBOARD_NAME_MAIN   = "Main"
let STORYBOARD_NAME_MEMBER = "Member"
let STORYBOARD_NAME_GROUP  = "Group"

// UserDefault
let SPLIT_MASTER_VIEW_CONTROLLER_WIDTH = "splitMasterViewControllerWidth"
let SPLIT_DETAIL_VIEW_CONTROLLER_WIDTH = "splitDetailViewControllerWidth"
let SPLIT_VIEW_CONTROLLER_HEIGHT       = "splitViewControllerHeight"

// Notification
let DROP_SELECTED_GROUP_NOTIFY_KEY = NSNotification.Name(rawValue: "dropSelectedGroupNotifyKey")

// Notification userInfo
let REMOVE_SELECTED_GROUP_BUTTON_NOTIFY_USER_KEY = "removeSelectedGroupButton"


//通訊錄Tab
let TAB_BOTTOM_LINE_COLOR      = 0xE94242 // 底線色碼
let TAB_SELECTED_TITLE_COLOR   = 0xE94242 // 已選文字色碼
let TAB_UNSELECTED_TITLE_COLOR = 0x9F9A94 // 未選文字色碼


// enum
enum TabType: Int {
    case GROUP  = 0
    case MEMBER = 1
    case NONE    = 2
}

enum OnlineType: Int {
    case AVAILABLE  = 0
    case BUSY       = 1
    case NO_DISTURB = 2
    case OFFLINE    = 3
}

// struct
struct SelectedGroupInfo {
    var rowIndex: Int?
    var name: String?
}

struct MainMenuIconInfo {
    var selectedIcon: String?
    var unselectedIcon: String?
}
