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


enum TableViewType: Int {
    case groups  = 0
    case members = 1
    case none    = 2
}
