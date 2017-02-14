//
//  Manager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/14.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class Manager: NSObject {

    static let shared = Manager()
    private override init(){}
    
    var loginManager: LoginManager = LoginManager()
    
}

