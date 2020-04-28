//
//  dp_GlobalVars.swift
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
    
    // [dp_PttViewController]
    
    // dp_AddMemberViewController
    static var dropSelectedMemberObserver: NSObjectProtocol? = nil
    
    // dp_CreateGroupViewController
    static var selectedMembersReloadedObserver: NSObjectProtocol? = nil
    
    // dp_GroupDispatchViewController
    static var dropSelectedGroupObserver: NSObjectProtocol? = nil
    
    // dp_DispatchBoardSplitViewController
    static var keepOriginalSplitViewControllerObserver: NSObjectProtocol? = nil
    
    // dp_MasterViewController
    static var changeMonitorObserver: NSObjectProtocol? = nil
    static var reloadGroupTableViewObserver: NSObjectProtocol? = nil
    
    // [dp_MapViewController]
    
    // dp_EditElectrFenceViewController
    static var autoSwitchPreferGroupChangedObserver: NSObjectProtocol? = nil
    static var enterAlarmChangedObserver: NSObjectProtocol? = nil
    static var enterAlarmVoicePlayChangedObserver: NSObjectProtocol? = nil
    static var exitAlarmChangedObserver: NSObjectProtocol? = nil
    static var exitAlarmVoicePlayChangedObserver: NSObjectProtocol? = nil


}
