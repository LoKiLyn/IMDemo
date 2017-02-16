//
//  NIMLogin.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class NIMLoginProvider: NSObject, IMLoginProtocol {
    
    internal func login(account: String, token: String, completion: @escaping (Error?) -> ()) {
        NIMSDK.shared().loginManager.login(account, token: token, completion: completion)
    }
    
    internal func autoLogin(account: String, token: String) {
        NIMSDK.shared().loginManager.autoLogin(account, token: token)
    }
    
    internal func logout(completion: @escaping (Error?) -> ()) {
        NIMSDK.shared().loginManager.logout(completion)
    }
    
    internal func isLogined() -> (Bool) {
        return NIMSDK.shared().loginManager.isLogined()
    }
    
    internal func currentAccount() -> (String) {
        return NIMSDK.shared().loginManager.currentAccount()
    }
}
