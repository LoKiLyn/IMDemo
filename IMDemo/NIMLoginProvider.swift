//
//  NIMLogin.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class NIMLoginProvider: NSObject, IMLoginProtocol {
    
    func login(account: String, token: String, completion: @escaping (Error?) -> ()) {
        NIMSDK.shared().loginManager.login(account, token: token, completion: completion)
    }
    
    func autoLogin(account: String, token: String) {
        NIMSDK.shared().loginManager.autoLogin(account, token: token)
    }
    
    func logout(completion: @escaping (Error?) -> ()) {
        NIMSDK.shared().loginManager.logout(completion)
    }
}
