//
//  dp_ConfigAndConst.swift
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

// 群組PTT動畫
let PTT_ANIMATION_IMAGES: [UIImage] = [UIImage(named: "bg_ptt_animation1")!,
                                       UIImage(named: "bg_ptt_animation2")!,
                                       UIImage(named: "bg_ptt_animation3")!,
                                       UIImage(named: "bg_ptt_animation4")!,
                                       UIImage(named: "bg_ptt_animation5")!,
                                       UIImage(named: "bg_ptt_animation6")!,
                                       UIImage(named: "bg_ptt_animation7")!,
                                       UIImage(named: "bg_ptt_animation8")!,
                                       UIImage(named: "bg_ptt_animation9")!]

// 群組成員PTT動畫
let GROUP_MEMBER_PTT_ANIMATION_IMAGES: [UIImage] = [UIImage(named: "bg_ptt_s_animation1")!,
                                       UIImage(named: "bg_ptt_s_animation2")!,
                                       UIImage(named: "bg_ptt_s_animation3")!,
                                       UIImage(named: "bg_ptt_s_animation4")!,
                                       UIImage(named: "bg_ptt_s_animation5")!,
                                       UIImage(named: "bg_ptt_s_animation6")!,
                                       UIImage(named: "bg_ptt_s_animation7")!,
                                       UIImage(named: "bg_ptt_s_animation8")!,
                                       UIImage(named: "bg_ptt_s_animation9")!]

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
let ADD_MEMBER_VIEW_CONTROLLER = "dp_AddMemberViewController"
let GROUP_DISPATCH_VIEW_CONTROLLER = "dp_GroupDispatchViewController"

// Segue
let SHOW_PTT_SEGUE = "showPttSegue"
let SHOW_MAP_SEGUE = "showMapSegue"

// Cell
let DP_GROUP_TABLE_VIEW_CELL  = "dp_GroupTableViewCell"  // nib name & cell name (the same)
let DP_MEMBER_TABLE_VIEW_CELL = "dp_MemberTableViewCell" // nib name & cell name (the same)
let DP_MAINMENU_COLLECTION_VIEW_CELL = "dp_MainMenuCollectionViewCell"
let DP_GROUP_COLLECTION_VIEW_CELL = "dp_GroupCollectionViewCell"
let DP_MEMBER_PROFILE_TABLE_VIEW_CELL = "dp_MemberProfileTableViewCell"
let DP_GROUP_DISPATCH_TABLE_VIEW_CELL = "dp_GroupDispatchTableViewCell"
let DP_GROUP_DISPATCH_COLLECTION_VIEW_CELL = "dp_GroupDispatchCollectionViewCell"
let DP_CREATE_GROUP_TABLE_VIEW_CELL = "dp_CreateGroupTableViewCell"
let DP_ADD_MEMBER_TABLE_VIEW_CELL = "dp_AddMemberTableViewCell"
let DP_ADD_MEMBER_COLLECTION_VIEW_CELL = "dp_AddMemberCollectionViewCell"
let DP_MAP_TABLE_VIEW_CELL = "dp_MapTableViewCell"
let DP_TEMPORARY_GROUP_TABLE_VIEW_CELL = "dp_TemporaryGroupTableViewCell"
let DP_GROUP_SETTING_INFO_TABLE_VIEW_CELL = "dp_GroupSettingInfoTableViewCell"
let DP_EDIT_ELECTR_FENCE_TABLE_VIEW_CELL = "dp_EditElectrFenceTableViewCell"


// Storyboard
let STORYBOARD_NAME_DP_MAIN   = "dp_Main"
let STORYBOARD_NAME_DP_MEMBER = "dp_Member"
let STORYBOARD_NAME_DP_GROUP  = "dp_Group"
let STORYBOARD_NAME_DP_MAP    = "dp_Map"

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
let AUTO_SWITCH_PREFER_GROUP_CHANGED_NOTIFY_KEY = Notification.Name("autoSwitchPreferGroupChangedNotifyKey")
let ENTER_ALARM_CHANGED_NOTIFY_KEY = Notification.Name("enterAlarmChangedNotifyKey")
let ENTER_ALARM_VOICE_PLAY_CHANGED_NOTIFY_KEY = Notification.Name("enterAlarmVoicePlayChangedNotifyKey")
let EXIT_ALARM_CHANGED_NOTIFY_KEY = Notification.Name("exitAlarmChangedNotifyKey")
let EXIT_ALARM_VOICE_PLAY_CHANGED_NOTIFY_KEY = Notification.Name("exitAlarmVoicePlayChangedNotifyKey")

// Notification userInfo
let DROP_SELECTED_GROUP_TABLE_CELL_USER_KEY = "dropSelectedGroupTableCellUserKey"
let DROP_SELECTED_MEMBER_TABLE_CELL_USER_KEY = "dropSelectedMemberTableCellUserKey"
let CHANGE_MONITOR_USER_KEY = "changeMonitorUserKey"
let SELECTED_MEMBERS_RELOADED_USER_KEY = "selectedMembersReloadedUserKey"
let KEEP_ORIGINAL_SPLIT_VIEW_CONTROLLER_USER_KEY = "keepOriginalSplitViewControllerUserKey"
let RELOAD_GROUP_TABLE_VIEW_USER_KEY = "reloadGroupTableViewObserverUserKey"
let SWITCH_MAIN_MENU_USER_KEY = "switchMainMenuUserKey"
let AUTO_SWITCH_PREFER_GROUP_CHANGED_USER_KEY = "autoSwitchPreferGroupChangedUserKey"
let ENTER_ALARM_CHANGED_USER_KEY = "enterAlarmChangedUserKey"
let ENTER_ALARM_VOICE_PLAY_CHANGED_USER_KEY = "enterAlarmVoicePlayChangedUserKey"
let EXIT_ALARM_CHANGED_USER_KEY = "exitAlarmChangedUserKey"
let EXIT_ALARM_VOICE_PLAY_CHANGED_USER_KEY = "exitAlarmVoicePlayChangedUserKey"

// 通訊錄Tab
let TAB_BOTTOM_LINE_COLOR      = 0xE94242 // 底線色碼
let TAB_SELECTED_TITLE_COLOR   = 0xE94242 // 已選文字色碼
let TAB_UNSELECTED_TITLE_COLOR = 0x9F9A94 // 未選文字色碼

// 點擊群組某成員彈出的畫面
let GROUP_MEMBER_BLUR_BACKGROUND_COLOR = 0xE7393B // 背景顏色
let GROUP_MEMBER_BLUR_BACKGROUND_COLOR_ALPHA = 0.75 // 背景顏色透明度

// enum
// [Common used]
enum MainMenuType: Int {
    case PTT    = 0
    case MAP    = 1
    case VIDEO  = 2
    case RECORD = 3
    
    case NONE   = 99
}

enum OnlineType: Int {
    case AVAILABLE  = 0
    case BUSY       = 1
    case NO_DISTURB = 2
    case OFFLINE    = 3
}

enum ButtonPressType: Int {
    case PRESSED = 0
    case AWAY    = 1
}

// [Ptt menu]
enum ShowPttSegueType: Int {
    case TAB_GROUP_SELECT  = 0
    case TAB_MEMBER_SELECT = 1
    case TAB_GROUP_CREATE_GROUP = 2
    
    case NONE = 99
}

enum PttContactTabType: Int {
    case GROUP  = 0
    case MEMBER = 1
    
    case NONE   = 99
}

enum GroupMemberCallingType: Int {
    case SIP_CALL = 0
    case PTT      = 1
    case VIDEO    = 2
}

enum GroupSettingType: CaseIterable {
    case MONITOR_MODE // 監聽模式
    case EDIT_GROUP   // 編輯群組
}

enum MemberProfileType: CaseIterable {
    case USER_ID    // 帳號
    case SIP_NUMBER // SIP號碼
    case COUNTRY    // 國家
    case EMAIL      // 電子信箱
}


// [Map menu]
enum ShowMapSegueType: Int {
    case MAP_SELECT      = 0 // (電子圍籬/ 即時定位/ 臨時群組)
    case EDIT_MAP_SELECT = 1 // (電子圍籬中的「編輯」)
    
    case NONE = 99
}

enum MapFunctionType: CaseIterable {
    case ELECTR_FENCE        // 電子圍籬
    case REAL_TIME_POSITION  // 即時定位
    case TEMPORARY_GROUP     // 臨時群組
}

// 警告設定顯示的cell樣式 (選擇清單(通報對象/群組/語音內容)/ 開關)
enum ElectrFenceAlarmSettingMode: CaseIterable {
    case SELECTED
    case SWITCH
}

enum ElectrFenceAllAlarmType: CaseIterable {
    case BASIC_ALRAM_TYPE
    enum BasicAlarmType: CaseIterable {
        case INTERNAL_NOTIFY_TARGET   // 內部通報對象
        case AUTO_SWITCH_PREFER_GROUP // 自動切換優先群組
        case PREFER_GROUP             // 優先群組
    }
    
    case ENTER_ALARM_TYPE
    enum EnterAlarmType: CaseIterable {
        case ENTER_ALARM            // 進入警告
        case ENTER_ALARM_VOICE_PLAY // 播放警示語音
        case ENTER_ALARM_VOICE      // 語音內容
    }

    case EXIT_ALARM_TYPE
    enum ExitAlarmType: CaseIterable {
        case EXIT_ALARM            // 離開警告
        case EXIT_ALARM_VOICE_PLAY // 播放警示語音
        case EXIT_ALARM_VOICE      // 語音內容
    }
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
    var groupsVo: [dp_GroupVo]?
}
