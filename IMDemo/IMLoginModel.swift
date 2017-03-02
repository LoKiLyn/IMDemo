//
//  NIMObject.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class IMLoginModel: NSObject {
    
    /**
     *  account   SDK账号
     */
    var account: String? {
        get {
            return self.account
        }
        set {
            self.account = newValue
        }
    }
    
    /**
     *  token     SDKToken
     */
    var token: String? {
        get {
            return self.token
        }
        set {
            self.token = newValue
        }
    }
    
}
