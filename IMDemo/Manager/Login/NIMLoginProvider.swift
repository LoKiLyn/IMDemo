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
    
    func login(model: IMLoginModel, completion: @escaping LoginHandler) {
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
    
    func autoLogin(model: IMLoginModel, completion: @escaping LoginHandler) {
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
    
    func logout(completion: @escaping LoginHandler) {
        NIMSDK.shared().loginManager.logout(completion)
    }
    
    func isLogined() -> (Bool) {
        return NIMSDK.shared().loginManager.isLogined()
    }
    
    func currentAccount() -> (String) {
        return NIMSDK.shared().loginManager.currentAccount()
    }
    
}
