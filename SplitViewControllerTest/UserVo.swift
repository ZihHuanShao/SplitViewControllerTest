//
//  UserVo.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/10.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class GroupVo {
    var name: String?
    var count: Int?
    var imageName: String?
    var desc: String?
    var monitorState = Bool()
    var isSelected = Bool()
    
    init(name: String?, count: Int?, imageName: String?, desc: String?, monitorState: Bool, isSelected: Bool) {
        self.name = name
        self.count = count
        self.imageName = imageName
        self.desc = desc
        self.monitorState = monitorState
        self.isSelected = isSelected
    }
}

class MemberVo {
    var name: String?
    var imageName: String?
    var userId: String?
    var sipId: String?
    var country: String?
    var email: String?
    var onlineState = OnlineType.OFFLINE
    var isSelected = Bool()
    
    
    
    init(name: String?, imageName: String?, userId: String?, sipId: String?, country: String?, email: String?, onlineState: OnlineType, isSelected: Bool) {
        self.name = name
        self.imageName = imageName
        self.userId = userId
        self.sipId = sipId
        self.country = country
        self.email = email
        self.onlineState = onlineState
        self.isSelected = isSelected
    }
    
    convenience init(name: String?) {
        self.init(name: name, imageName: "", userId: "", sipId: "", country: "", email: "", onlineState: OnlineType.OFFLINE, isSelected: false)
    }
    
    
}


class MainMenuIconVo {
    var selectedIconName: String?
    var unselectedIconName: String?
    var isSelected = Bool()
    
    init(selectedIconName: String?, unselectedIconName: String?, isSelected: Bool) {
        self.selectedIconName = selectedIconName
        self.unselectedIconName = unselectedIconName
        self.isSelected = isSelected
    }
}


class SelectedGroupVo {
    var tableRowIndex: Int?
    var groupVo: GroupVo?
    
    init(tableRowIndex: Int?, groupVo: GroupVo?) {
        self.tableRowIndex = tableRowIndex
        self.groupVo = groupVo
    }
}

class SelectedMemberVo {
    var tableRowIndex: Int?
    var memberVo: MemberVo?
    
    init(tableRowIndex: Int?, memberVo: MemberVo?) {
        self.tableRowIndex = tableRowIndex
        self.memberVo = memberVo
    }
}
