//
//  ConfigAndConst.swift
//  SplitViewControllerTest
//
//  Created by maxkitmac on 2020/3/27.
//  Copyright © 2020年 fredshao. All rights reserved.
//

import Foundation

let GROUPS_TABLE_VIEW_CELL  = "GroupsTableViewCell"  // nib name & cell name (the same)
let MEMBERS_TABLE_VIEW_CELL = "MembersTableViewCell" // nib name & cell name (the same)
let MAINMENU_COLLECTION_VIEW_CELL = "MainMenuCollectionViewCell"

//通訊錄Tab
let TAB_BOTTOM_LINE_COLOR      = 0xE94242 // 底線色碼
let TAB_SELECTED_TITLE_COLOR   = 0xE94242 // 已選文字色碼
let TAB_UNSELECTED_TITLE_COLOR = 0x9F9A94 // 未選文字色碼

enum TableViewType: Int {
    case groups  = 0
    case members = 1
    case none    = 2
}
