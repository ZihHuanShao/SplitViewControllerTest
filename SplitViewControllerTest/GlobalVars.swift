//
//  GlobalVars.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/15.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation


class gVar {
    
    // 避免連續點擊兩次以上, 造成不可預期的問題
    static var isHoldFormSheetView = false
    
    //
    // Notification
    //
    
    static var switchMainMenuObserver: NSObjectProtocol? = nil
    
    // [PttViewController]
    
    // AddMemberViewController
    static var dropSelectedMemberObserver: NSObjectProtocol? = nil
    
    // CreateGroupViewController
    static var selectedMembersReloadedObserver: NSObjectProtocol? = nil
    
    // GroupDispatchViewController
    static var dropSelectedGroupObserver: NSObjectProtocol? = nil
    
    // DispatchBoardSplitViewController
    static var keepOriginalSplitViewControllerObserver: NSObjectProtocol? = nil
    
    // MasterViewController
    static var changeMonitorObserver: NSObjectProtocol? = nil
    static var reloadGroupTableViewObserver: NSObjectProtocol? = nil
    
    // [MapViewController]
    
    // EditElectrFenceViewController
    static var autoSwitchPreferGroupChangedObserver: NSObjectProtocol? = nil
    static var enterAlarmChangedObserver: NSObjectProtocol? = nil
    static var enterAlarmVoicePlayChangedObserver: NSObjectProtocol? = nil
    static var exitAlarmChangedObserver: NSObjectProtocol? = nil
    static var exitAlarmVoicePlayChangedObserver: NSObjectProtocol? = nil


}
