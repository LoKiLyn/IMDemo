//
//  LoginManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/13.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

protocol IMLoginProtocol: NSObjectProtocol {
    func login(account:String, token:String, completion: @escaping (Error?) -> ())
    func autoLogin(account:String, token:String)
    func logout(completion: @escaping (Error?) -> ())
    func currentAccount() -> (String)
    func isLogined() -> (Bool)
}

class IMLoginManager: NSObject{
    
    enum loginError: Error {
        case NoAccount
        case NoPassword
    }
    
    enum SDKType: NSInteger {
        case Nim
    }
    
    typealias LoginHandler = (Error?) -> ()
    
    var loginProvider: IMLoginProtocol = NIMLoginProvider()
    var loginModel: BaseLoginModel = NIMLoginModel()
    
    /**
     *  切换SDK
     *
     *  @param SDKType   SDK
     */
    func switchSDK(SDKType:SDKType){
        switch SDKType {
        case .Nim:
            //MARK: Remain to be improved.
            loginProvider = NIMLoginProvider()
            loginModel = NIMLoginModel()
        }
    }
    
    /**
     *  登录
     *
     *  @param model      登陆模型
     *  @param completion 完成回调
     */
    func login(model: BaseLoginModel, completion: @escaping LoginHandler){
        if (model.account == nil) {
            completion(loginError.NoAccount)
        }else if (model.token == nil) {
            completion(loginError.NoPassword)
        }else{
            let account = model.account
            let token = model.token
            loginProvider.login(account: account!, token: token!, completion: completion)
        }
    }
    
    /**
     *  自动登录
     *
     *  @param account    帐号
     *  @param token      令牌 (在后台绑定的登录token)
     *  @discussion 启动APP如果已经保存了用户帐号和令牌,建议使用这个登录方式,使用这种方式可以在无网络时直接打开会话窗口
     */
    // MARK: To be tested.
    func autologin(model: BaseLoginModel, completion: @escaping LoginHandler){
        if (model.account == nil) {
            completion(loginError.NoAccount)
        }else if (model.token == nil) {
            completion(loginError.NoPassword)
        }else{
            let account = model.account
            let token = model.token
            loginProvider.autoLogin(account: account!, token: token!)
        }
    }
    
    /**
     *  登出
     *
     *  @param completion 完成回调
     *  @discussion 用户在登出是需要调用这个接口进行 SDK 相关数据的清理,回调 Block 中的 error 只是指明和服务器的交互流程中可能出现的错误,但不影响后续的流程。
     *              如用户登出时发生网络错误导致服务器没有收到登出请求，客户端仍可以登出(切换界面，清理数据等)，但会出现推送信息仍旧会发到当前手机的问题。
     */
    func logout(completion:@escaping LoginHandler){
        NIMSDK.shared().loginManager.logout(completion)
    }
    
    /**
     *  返回当前登录帐号
     *
     *  @return 当前登录帐号,如果没有登录成功,这个地方会返回空字符串""
     */
    func currentAccount() -> (String){
        return NIMSDK.shared().loginManager.currentAccount()
    }
    
    /**
     *  当前登录状态
     *
     *  @return 当前登录状态
     */
    func isLogined() -> (Bool){
        return NIMSDK.shared().loginManager.isLogined()
    }
    
}
