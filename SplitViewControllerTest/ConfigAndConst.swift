//
//  ConfigAndConst.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation

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

//通訊錄Tab
let TAB_BOTTOM_LINE_COLOR      = 0xE94242 // 底線色碼
let TAB_SELECTED_TITLE_COLOR   = 0xE94242 // 已選文字色碼
let TAB_UNSELECTED_TITLE_COLOR = 0x9F9A94 // 未選文字色碼

enum TabType: Int {
    case groups  = 0
    case members = 1
    case none    = 2
}

struct GroupInfo {
    var groupName: String?
    var groupNumber: Int?
    var groupImage: String?
    var groupDesc: String?
}

struct SelectedGroupInfo {
    var rowIndex: Int?
    var name: String?
}
