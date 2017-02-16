//
//  LoginManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/13.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

typealias LoginHandler = (Error?) -> ()

protocol IMLoginProtocol: NSObjectProtocol {
    func login(model: BaseLoginModel, completion: @escaping LoginHandler)
    func autoLogin(model: BaseLoginModel, completion: @escaping LoginHandler)
    func logout(completion: @escaping LoginHandler)
    func currentAccount() -> (String)
    func isLogined() -> (Bool)
}

class IMLoginManager: NSObject{
    
    var loginProvider: IMLoginProtocol?
    var loginModel: BaseLoginModel?
    
    /**
     *  登录
     *
     *  @param model      登陆模型
     *  @param completion 完成回调
     */
    func login(model: BaseLoginModel, completion: @escaping LoginHandler){
        loginProvider!.login(model: model, completion: completion)
    }
    
    /**
     *  自动登录
     *
     *  @param model      登陆模型
     *  @param completion 完成回调
     *  @discussion 启动APP如果已经保存了用户帐号和令牌,建议使用这个登录方式,使用这种方式可以在无网络时直接打开会话窗口
     */
    func autologin(model: BaseLoginModel, completion: @escaping LoginHandler){
        loginProvider!.autoLogin(model: model, completion: completion)
    }
    
    /**
     *  登出
     *
     *  @param completion 完成回调
     *  @discussion 用户在登出是需要调用这个接口进行 SDK 相关数据的清理,回调 Block 中的 error 只是指明和服务器的交互流程中可能出现的错误,但不影响后续的流程。
     *              如用户登出时发生网络错误导致服务器没有收到登出请求，客户端仍可以登出(切换界面，清理数据等)，但会出现推送信息仍旧会发到当前手机的问题。
     */
    func logout(completion:@escaping LoginHandler){
        loginProvider!.logout(completion: completion)
    }
    
    /**
     *  返回当前登录帐号
     *
     *  @return 当前登录帐号,如果没有登录成功,这个地方会返回空字符串""
     */
    func currentAccount() -> (String){
        return loginProvider!.currentAccount()
    }
    
    /**
     *  当前登录状态
     *
     *  @return 当前登录状态
     */
    func isLogined() -> (Bool){
        return loginProvider!.isLogined()
    }
    
}
