//
//  LoginManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/13.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class LoginManager: NSObject {
    static let shared = LoginManager()
    
    /**
     *  登录
     *
     *  @param login    帐号
     *  @param token    令牌 (在后台绑定的登录token)
     *  @param completion 完成回调
     */
    func login(login: String, token: String, completion: @escaping (Error?) -> ()){
        NIMSDK.shared().loginManager.login(login, token: token, completion: completion)
    }
    
    /**
     *  自动登录
     *
     *  @param account    帐号
     *  @param token      令牌 (在后台绑定的登录token)
     *  @discussion 启动APP如果已经保存了用户帐号和令牌,建议使用这个登录方式,使用这种方式可以在无网络时直接打开会话窗口
     */
    func autologin(account: String, token: String){
        NIMSDK.shared().loginManager.autoLogin(account, token: token)
    }
    
    /**
     *  登出
     *
     *  @param completion 完成回调
     *  @discussion 用户在登出是需要调用这个接口进行 SDK 相关数据的清理,回调 Block 中的 error 只是指明和服务器的交互流程中可能出现的错误,但不影响后续的流程。
     *              如用户登出时发生网络错误导致服务器没有收到登出请求，客户端仍可以登出(切换界面，清理数据等)，但会出现推送信息仍旧会发到当前手机的问题。
     */
    func logout(completion:@escaping (Error?) -> ()){
        NIMSDK.shared().loginManager.logout(completion)
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

class UserManager: NSObject {
    static let shared = UserManager()

    /**
     *  添加好友
     *
     *  @param friendID    好友账号
     *  @param completion 完成回调
     */
    
    func addFriend(friendID: String, completion:@escaping (Error?) -> ()){
        let request = NIMUserRequest()
        request.userId = friendID
        NIMSDK.shared().userManager.requestFriend(request, completion: completion)
    }

}
