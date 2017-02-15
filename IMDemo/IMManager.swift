//
//  Manager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/14.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class IMManager: NSObject {

    static let shared = IMManager()
    private override init(){}
    
    var loginManager: IMLoginManager = IMLoginManager()
    var teamManager: IMTeamManager = IMTeamManager()
}

