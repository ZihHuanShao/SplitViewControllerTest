//
//  UserVo.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/10.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation

class GroupVo {
    var name: String?
    var count: Int?
    var imageName: String?
    var desc: String?
    var notifyState = Bool()
    var isSelected = Bool()
    
    init(name: String?, count: Int?, imageName: String?, desc: String?, notifyState: Bool, isSelected: Bool) {
        self.name = name
        self.count = count
        self.imageName = imageName
        self.desc = desc
        self.notifyState = notifyState
        self.isSelected = isSelected
    }
}

class MemberVo {
    var name: String?
    var imageName: String?
    var onlineState = OnlineType.OFFLINE
    var isSelected = Bool()
    
    init(name: String?, imageName: String?, onlineState: OnlineType, isSelected: Bool) {
        self.name = name
        self.imageName = imageName
        self.onlineState = onlineState
        self.isSelected = isSelected
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
