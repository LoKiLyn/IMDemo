//
//  NIMLogin.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class NIMLoginProvider: NSObject, IMLoginProtocol {
    
    enum loginError: Error {
        case NoAccount
        case NoPassword
    }
    
    internal func login(model:BaseLoginModel, completion: @escaping LoginHandler) {
        if (model.account == nil) {
            completion(loginError.NoAccount)
        } else if (model.token == nil) {
            completion(loginError.NoPassword)
        } else {
            let account = model.account
            let token = model.token
            NIMSDK.shared().loginManager.login(account!, token: token!, completion: completion)
        }
    }
    
    internal func autoLogin(model:BaseLoginModel, completion: @escaping LoginHandler) {
        if (model.account == nil) {
            completion(loginError.NoAccount)
        }else if (model.token == nil) {
            completion(loginError.NoPassword)
        }else{
            let account = model.account
            let token = model.token
            NIMSDK.shared().loginManager.autoLogin(account!, token: token!)
        }
    }
    
    internal func logout(completion: @escaping LoginHandler) {
        NIMSDK.shared().loginManager.logout(completion)
    }
    
    internal func isLogined() -> (Bool) {
        return NIMSDK.shared().loginManager.isLogined()
    }
    
    internal func currentAccount() -> (String) {
        return NIMSDK.shared().loginManager.currentAccount()
    }
    
}
