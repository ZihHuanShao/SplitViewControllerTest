//
//  ConfigAndConst.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation
import UIKit
import MapKit

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
let DISP_ADD_MEMBER_VIEW_CONTROLLER = "DispAddMemberViewController"
let DISP_GROUP_DISPATCH_VIEW_CONTROLLER = "DispGroupDispatchViewController"
let DISP_EDIT_COLOR_VIEW_CONTROLLER = "DispEditColorViewController"

// Segue
let SHOW_PTT_SEGUE = "showPttSegue"
let SHOW_MAP_SEGUE = "showMapSegue"

// Cell
let DISP_GROUP_TABLE_VIEW_CELL  = "DispGroupTableViewCell"  // nib name & cell name (the same)
let DISP_MEMBER_TABLE_VIEW_CELL = "DispMemberTableViewCell" // nib name & cell name (the same)
let DISP_MAINMENU_COLLECTION_VIEW_CELL = "DispMainMenuCollectionViewCell"
let DISP_GROUP_COLLECTION_VIEW_CELL = "DispGroupCollectionViewCell"
let DISP_MEMBER_PROFILE_TABLE_VIEW_CELL = "DispMemberProfileTableViewCell"
let DISP_GROUP_DISPATCH_TABLE_VIEW_CELL = "DispGroupDispatchTableViewCell"
let DISP_GROUP_DISPATCH_COLLECTION_VIEW_CELL = "DispGroupDispatchCollectionViewCell"
let DISP_CREATE_GROUP_TABLE_VIEW_CELL = "DispCreateGroupTableViewCell"
let DISP_ADD_MEMBER_TABLE_VIEW_CELL = "DispAddMemberTableViewCell"
let DISP_ADD_MEMBER_COLLECTION_VIEW_CELL = "DispAddMemberCollectionViewCell"
let DISP_MAP_TABLE_VIEW_CELL = "DispMapTableViewCell"
let DISP_TEMPORARY_GROUP_TABLE_VIEW_CELL = "DispTemporaryGroupTableViewCell"
let DISP_GROUP_SETTING_INFO_TABLE_VIEW_CELL = "DispGroupSettingInfoTableViewCell"
let DISP_EDIT_ELECTR_FENCE_TABLE_VIEW_CELL = "DispEditElectrFenceTableViewCell"


// Storyboard
let STORYBOARD_NAME_DISP_MAIN   = "DispMain"
let STORYBOARD_NAME_DISP_MEMBER = "DispMember"
let STORYBOARD_NAME_DISP_GROUP  = "DispGroup"
let STORYBOARD_NAME_DISP_MAP    = "DispMap"

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
let CHANGE_COLOR_NOTIFY_KEY = Notification.Name("changeColorNotifyKey")
let CREATE_ELECTR_FENCE_SETTING_NOTIFY_KEY = NSNotification.Name("createElectrFenceSettingNotifyKey")

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
let CHANGE_COLOR_USER_KEY = "changeColorUserKey"
let CREATE_ELECTR_FENCE_SETTING_USER_KEY = "createElectrFenceSettingUserKey"

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
    case TAB_GROUP_SELECT  = 0      // 群組
    case TAB_MEMBER_SELECT = 1      // 聯絡人
    case TAB_GROUP_CREATE_GROUP = 2 // 群組中的「建立群組」
    
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
    case MAP = 0                 // 地圖首頁
    case ELECTR_FENCE = 1        // 電子圍籬
    case CREATE_ELECTR_FENCE = 2 // 電子圍籬中的「新增電子圍籬」
    case EDIT_ELECTR_FENCE = 3   // 電子圍籬中的「設定」
    case REAL_TIME_POSITION = 4  // 即時定位
    case TEMPORARY_GROUP = 5     // 臨時群組
    
    
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

enum DragType: Int {
    case dragWithFinishDrawing       = 0 // 移動頂點 && 多邊形還已繪製完
    case dragWithoutFinishingDrawing = 1 // 移動頂點 && 多邊形還沒繪製完
    case dragWithKeepDrawing         = 2 // 建立新頂點
}

enum CreateElectrFenceType: Int {
    case DRAW_SCOPE = 0     // 框選範圍
    case CREATE_SCOPE = 1   // 建立圍籬
}

enum EditElectrFenceDisplayType: Int {
    case CREATE = 0
    case EDIT   = 1
    
    case NONE   = 99
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

struct RGBColorCode {
    var red = Int()
    var green = Int()
    var blue = Int()
}

struct EditElectrFenceDisplayCreateModeInfo {
    let type = EditElectrFenceDisplayType.CREATE
    var coordinates: [CLLocationCoordinate2D]?
}

struct EditElectrFenceDisplayEditModeInfo {
    let type = EditElectrFenceDisplayType.EDIT
    // other 圍籬資訊
}
