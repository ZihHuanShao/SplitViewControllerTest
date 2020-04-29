//
//  dp_UserVo.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/10.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation
import UIKit

class dp_GroupVo {
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

class dp_MemberVo {
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


class dp_MainMenuIconVo {
    var selectedIconName: String?
    var unselectedIconName: String?
    var isSelected = Bool()
    
    init(selectedIconName: String?, unselectedIconName: String?, isSelected: Bool) {
        self.selectedIconName = selectedIconName
        self.unselectedIconName = unselectedIconName
        self.isSelected = isSelected
    }
}


class dp_SelectedGroupVo {
    var tableRowIndex: Int?
    var dp_groupVo: dp_GroupVo?
    
    init(tableRowIndex: Int?, dp_groupVo: dp_GroupVo?) {
        self.tableRowIndex = tableRowIndex
        self.dp_groupVo = dp_groupVo
    }
}

class dp_SelectedMemberVo {
    var tableRowIndex: Int?
    var dp_memberVo: dp_MemberVo?
    
    init(tableRowIndex: Int?, dp_memberVo: dp_MemberVo?) {
        self.tableRowIndex = tableRowIndex
        self.dp_memberVo = dp_memberVo
    }
}

class dp_ElectrFenceVo {
    var title: String?
    var color: UInt? = 0xFF0000 // default red color

    var notifyTarget: dp_MemberVo?
    var autoSwitchPreferGroupEnabled = Bool()
    var preferGroup: dp_GroupVo?
    
    var enterAlarmEnabled = Bool()
    var enterAlarmVoicePlayEnabled = Bool()
    var enterAlarmVoice: String?
    
    var exitAlarmEnabled = Bool()
    var exitAlarmVoicePlayEnabled = Bool()
    var exitAlarmVoice: String?
    
    init(title: String?, color: UInt?, notifyTarget: dp_MemberVo?, autoSwitchPreferGroupEnabled: Bool, preferGroup: dp_GroupVo?, enterAlarmEnabled: Bool, enterAlarmVoicePlayEnabled: Bool, enterAlarmVoice: String?, exitAlarmEnabled: Bool, exitAlarmVoicePlayEnabled: Bool, exitAlarmVoice: String) {
        self.title = title
        self.color = color
        self.notifyTarget = notifyTarget
        self.autoSwitchPreferGroupEnabled = autoSwitchPreferGroupEnabled
        self.preferGroup = preferGroup
        self.enterAlarmEnabled = enterAlarmEnabled
        self.enterAlarmVoicePlayEnabled = enterAlarmVoicePlayEnabled
        self.enterAlarmVoice = enterAlarmVoice
        self.exitAlarmEnabled = exitAlarmEnabled
        self.exitAlarmVoicePlayEnabled = exitAlarmVoicePlayEnabled
        self.exitAlarmVoice = exitAlarmVoice
    }
}
