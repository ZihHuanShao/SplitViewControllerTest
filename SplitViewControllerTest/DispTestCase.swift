//
//  TestCase.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/10.
//  Copyright © 2020 fredshao. All rights reserved.
//

import Foundation

//
// 群組 (name, imageName, count, desc, monitorState, isSelected)
//

let TEST_GROUPS: [GroupInfo] =
    [GroupInfo(name: "Martin Group", count: 6, imageName: nil, desc: "Martin Group", monitorState: false, isSelected: false),
     GroupInfo(name: "Charley Group", count: 35, imageName: nil, desc: "Charley Group", monitorState: false, isSelected: false),
     GroupInfo(name: "Fred Group", count: 18, imageName: nil, desc: "Fred Group", monitorState: false, isSelected: false),
     GroupInfo(name: "May Group", count: 26, imageName: nil, desc: "May Group", monitorState: false, isSelected: false),
     GroupInfo(name: "Michael Group", count: 50, imageName: nil, desc: "Michael Group", monitorState: false, isSelected: false),
     GroupInfo(name: "Maxkit Group", count: 40, imageName: nil, desc: "Maxkit Group", monitorState: false, isSelected: false),
     GroupInfo(name: "Test Group 001", count: 17, imageName: nil, desc: "Test Group 001", monitorState: false, isSelected: false),
     GroupInfo(name: "Test Group 002", count: 63, imageName: nil, desc: "Test Group 002", monitorState: false, isSelected: false),
     GroupInfo(name: "Test Group 003", count: 38, imageName: nil, desc: "Test Group 003", monitorState: false, isSelected: false),
     GroupInfo(name: "Test Group 004", count: 27, imageName: nil, desc: "Test Group 004", monitorState: false, isSelected: false),
     GroupInfo(name: "Test Group 005", count: 47, imageName: nil, desc: "Test Group 005", monitorState: false, isSelected: false),
     GroupInfo(name: "Test Group 006", count: 21, imageName: nil, desc: "Test Group 006", monitorState: false, isSelected: false)]

//
// 聯絡人 (name, imageName, userId, sipId, country, email, onlineState, isSelected)
//

let TEST_MEMBERS: [MemberInfo] =
    [MemberInfo(name: "Martin", imageName: nil, userId: "001", sipId: "1111", country: "Taiwan", email: "Martin@maxkit.com.tw", onlineState: .AVAILABLE, isSelected: false),
     MemberInfo(name: "Charley", imageName: nil, userId: "002", sipId: "2222", country: "Taiwan", email: "Charley@maxkit.com.tw", onlineState: .OFFLINE, isSelected: false),
     MemberInfo(name: "Fred", imageName: nil, userId: "003", sipId: "3333", country: "Taiwan", email: "Fred@maxkit.com.tw", onlineState: .BUSY, isSelected: false),
     MemberInfo(name: "Michael", imageName: nil, userId: "004", sipId: "4444", country: "Taiwan", email: "Michael@maxkit.com.tw", onlineState: .OFFLINE, isSelected: false),
     MemberInfo(name: "MayMay", imageName: nil, userId: "005", sipId: "5555", country: "Taiwan", email: "MayMay@maxkit.com.tw", onlineState: .NO_DISTURB, isSelected: false),
     MemberInfo(name: "A001", imageName: nil, userId: "006", sipId: "6666", country: "Taiwan", email: "A001@maxkit.com.tw", onlineState: .NO_DISTURB, isSelected: false),
     MemberInfo(name: "A002", imageName: nil, userId: "007", sipId: "7777", country: "Taiwan", email: "A002@maxkit.com.tw", onlineState: .AVAILABLE, isSelected: false),
     MemberInfo(name: "A003", imageName: nil, userId: "008", sipId: "8888", country: "Taiwan", email: "A003@maxkit.com.tw", onlineState: .AVAILABLE, isSelected: false),
     MemberInfo(name: "A004", imageName: nil, userId: "009", sipId: "9999", country: "Taiwan", email: "A004@maxkit.com.tw", onlineState: .NO_DISTURB, isSelected: false),
     MemberInfo(name: "A005", imageName: nil, userId: "010", sipId: "10000", country: "Taiwan", email: "A005@maxkit.com.tw", onlineState: .BUSY, isSelected: false)]
    
