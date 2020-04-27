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
    
    convenience init(name: String?) {
        self.init(name: name, count: 0, imageName:"", desc: "", monitorState: true, isSelected: true)
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

class ElectrFenceVo {
    var title: String?
    var color: UInt? = 0xFF0000 // default red color

    var notifyTarget: MemberVo?
    var enableAutoSwitchPreferGroup = Bool()
    var preferGroup: GroupVo?
    
    var enableEnterAlarm = Bool()
    var enablePlayEnterAlarmVoice = Bool()
    var enterAlarmVoice: String?
    
    var enableExitAlarm = Bool()
    var enablePlayExitAlarmVoice = Bool()
    var exitAlarmVoice: String?
    
    init(title: String?, color: UInt?, notifyTarget: MemberVo?, enableAutoSwitchPreferGroup: Bool, preferGroup: GroupVo?, enableEnterAlarm: Bool, enablePlayEnterAlarmVoice: Bool, enterAlarmVoice: String?, enableExitAlarm: Bool, enablePlayExitAlarmVoice: Bool, exitAlarmVoice: String) {
        self.title = title
        self.color = color
        self.notifyTarget = notifyTarget
        self.enableAutoSwitchPreferGroup = enableAutoSwitchPreferGroup
        self.preferGroup = preferGroup
        self.enableEnterAlarm = enableEnterAlarm
        self.enablePlayEnterAlarmVoice = enablePlayEnterAlarmVoice
        self.enterAlarmVoice = enterAlarmVoice
        self.enableExitAlarm = enableExitAlarm
        self.enablePlayExitAlarmVoice = enablePlayExitAlarmVoice
        self.exitAlarmVoice = exitAlarmVoice
    }
}
