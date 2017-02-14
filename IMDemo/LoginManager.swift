//
//  LoginManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/13.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class LoginManager: NSObject {
    
    typealias LoginHandler = (Error?) -> ()
    
    /**
     *  登录
     *
     *  @param login    帐号
     *  @param token    令牌 (在后台绑定的登录token)
     *  @param completion 完成回调
     */
    func login(login: String, token: String, completion: @escaping LoginHandler){
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

@objc protocol TeamManagerDelegate {
    
    @objc optional
    /**
     *  群组增加回调
     *
     *  @param team 添加的群组
     */
    func onTeamAdded(team:NIMTeam)
}

class TeamManager: NSObject {
    
    typealias TeamCreateHandler = (Error?, _ teamID: String?) -> Void
    typealias TeamHandler = (Error?) -> Void
    
    /**
     *  创建群组
     *
     *  @param users 初始添加用户
     *  @param completion 完成回调(error,teamID)
     */
    
    func createTeam(users:Array<String>, completion:@escaping TeamCreateHandler) {
        let teamOption = NIMCreateTeamOption()
        //群名称
        teamOption.name = ""
        //谁可以邀请群成员
        teamOption.inviteMode = NIMTeamInviteMode.all
        //被邀请人验证方式
        teamOption.beInviteMode = NIMTeamBeInviteMode.noAuth
        //群验证方式
        teamOption.joinMode = NIMTeamJoinMode.noAuth
        NIMSDK.shared().teamManager.createTeam(teamOption, users: users, completion: completion)
    }
    
    /**
     *  是否已有群组
     *
     *  @return 当前群组状态
     */
    
    func hasJoinedATeam() -> (Bool) {
        return (NIMSDK.shared().teamManager.allMyTeams()?.count)! >= 1
    }
    
    /**
     *  解散群组
     *
     *  @param teamId      群组ID
     *  @param completion  完成后的回调
     */
    
    func dismissTeam(teamID: String, completion: @escaping TeamHandler) {
        NIMSDK.shared().teamManager.dismissTeam(teamID, completion: completion)
    }
    
}
