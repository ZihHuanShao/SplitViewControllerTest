//
//  TestCase.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/10.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation

//
// 群組 (name, imageName, count, desc, notifyState, isSelected)
//

let TEST_GROUPS: [GroupInfo] =
    [GroupInfo(name: "Martin Group", count: 6, imageName: nil, desc: "Martin Group", notifyState: false, isSelected: false),
     GroupInfo(name: "Charley Group", count: 35, imageName: nil, desc: "Charley Group", notifyState: false, isSelected: false),
     GroupInfo(name: "Fred Group", count: 18, imageName: nil, desc: "Fred Group", notifyState: false, isSelected: false),
     GroupInfo(name: "May Group", count: 26, imageName: nil, desc: "May Group", notifyState: false, isSelected: false),
     GroupInfo(name: "Michael Group", count: 50, imageName: nil, desc: "Michael Group", notifyState: false, isSelected: false),
     GroupInfo(name: "Maxkit Group", count: 40, imageName: nil, desc: "Maxkit Group", notifyState: false, isSelected: false),
     GroupInfo(name: "Test Group 00001", count: 17, imageName: nil, desc: "Test Group 00001", notifyState: false, isSelected: false),
     GroupInfo(name: "Test Group 00002", count: 63, imageName: nil, desc: "Test Group 00002", notifyState: false, isSelected: false),
     GroupInfo(name: "Test Group 00003", count: 38, imageName: nil, desc: "Test Group 00003", notifyState: false, isSelected: false),
     GroupInfo(name: "Test Group 00004", count: 27, imageName: nil, desc: "Test Group 00004", notifyState: false, isSelected: false),
     GroupInfo(name: "Test Group 00005", count: 47, imageName: nil, desc: "Test Group 00005", notifyState: false, isSelected: false),
     GroupInfo(name: "Test Group 00006", count: 21, imageName: nil, desc: "Test Group 00006", notifyState: false, isSelected: false)
     
]

//
// 聯絡人
//

let TEST_MEMBERS: [MemberInfo] =
    [MemberInfo(name: "Martin", imageName: nil, onlineState: .AVAILABLE, isSelected: false),
     MemberInfo(name: "Charley", imageName: nil, onlineState: .OFFLINE, isSelected: false),
     MemberInfo(name: "Fred", imageName: nil, onlineState: .BUSY, isSelected: false),
     MemberInfo(name: "Michael", imageName: nil, onlineState: .NO_DISTURB, isSelected: false),
     MemberInfo(name: "MayMay", imageName: nil, onlineState: .OFFLINE, isSelected: false)
    ]
