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
    
    // [DispPttViewController]
    
    // DispAddMemberViewController
    static var dropSelectedMemberObserver: NSObjectProtocol? = nil
    
    // DispCreateGroupViewController
    static var selectedMembersReloadedObserver: NSObjectProtocol? = nil
    
    // DispGroupDispatchViewController
    static var dropSelectedGroupObserver: NSObjectProtocol? = nil
    
    // DispatchBoardSplitViewController
    static var keepOriginalSplitViewControllerObserver: NSObjectProtocol? = nil
    
    // MasterViewController
    static var changeMonitorObserver: NSObjectProtocol? = nil
    static var reloadGroupTableViewObserver: NSObjectProtocol? = nil
    
    // [DispMapViewController]
    
    // DispEditElectrFenceViewController
    static var autoSwitchPreferGroupChangedObserver: NSObjectProtocol? = nil
    static var enterAlarmChangedObserver: NSObjectProtocol? = nil
    static var enterAlarmVoicePlayChangedObserver: NSObjectProtocol? = nil
    static var exitAlarmChangedObserver: NSObjectProtocol? = nil
    static var exitAlarmVoicePlayChangedObserver: NSObjectProtocol? = nil
    static var changeColorObserver: NSObjectProtocol? = nil

}
