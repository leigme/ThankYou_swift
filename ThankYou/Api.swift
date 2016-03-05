//
//  ApiUrl.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/3.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

struct ApiUrl {
    
    let LoginUrl : String
    let FriendCircleUrl : String
    
    init() {
        LoginUrl = "http://www.k12chn.com/edu/m17/Login/Index"
        FriendCircleUrl = "http://192.168.0.139/edu/m17/FriendCircle/GetAllFriendCircle"
    }
}

struct ApiLoginResponse {
    var Uid : String
    var Key : String
    var User : String
    var Pwd : String
    var Flag : String
    
    init () {
        Uid = ""
        Key = ""
        User = ""
        Pwd = ""
        Flag = ""
    }
}
