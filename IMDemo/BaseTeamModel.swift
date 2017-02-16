//
//  IMTeamModel.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class BaseTeamModel: NSObject {
    //创建群组时的初始用户
    var initialUsers: Array<String>?
    //群组ID
    var teamID: String?
    //添加群组成员
    var usersToAdd: Array<String>?
    //邀请信息
    var postScript: String = ""
}
