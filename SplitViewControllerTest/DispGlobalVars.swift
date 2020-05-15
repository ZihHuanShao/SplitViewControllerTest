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
    
    // 當彈出Modal視窗時, 系統會離開當前VC的生命週期, 如果在VC的生命週期(viewWillDisappear/ viewDidDisappear/ ..)設定全域變數,
    // 會造成邏輯錯誤, 因此利用此flag擋, 在彈出前設true, 離開彈出的視窗後再設回false
    static var presentModal = false
    
    class Map {
        // 判斷是否要顯示圍籬地圖, 若為CREATE則顯示, 若為EDIT則維持在原頁面
        static var editElectrFenceDisplayType = EditElectrFenceDisplayType.NONE
    }
    
    // Notification used
    class Notification {
    
        // [MasterViewController]
        
        static var switchMainMenuObserver: NSObjectProtocol? = nil
        
        // [DetailViewController]
        
        static var createElectrFenceSettingObserver: NSObjectProtocol? = nil
        
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
        static var colorChangedObserver: NSObjectProtocol? = nil
        
        // DispElectrFenceViewController
        static var updateNewElectrFenceVoObserver: NSObjectProtocol? = nil
        static var updateExistElectrFenceVoObserver: NSObjectProtocol? = nil
        static var editFenceScopeButtonHandlerObserver: NSObjectProtocol? = nil
        static var updateElectrFenceVoObserver: NSObjectProtocol? = nil
        static var borderColorButtonHandlerObserver: NSObjectProtocol? = nil
        static var borderColorChangedObserver: NSObjectProtocol? = nil
        static var sectionHeadButtonHandlerObserver: NSObjectProtocol? = nil
        static var settingButtonHandlerObserver: NSObjectProtocol? = nil
        static var enterAlarmButtonHandlerObserver: NSObjectProtocol? = nil
        static var exitAlarmButtonHandlerObserver: NSObjectProtocol? = nil
        static var reloadElectrFenceObserver: NSObjectProtocol? = nil
    }
}
