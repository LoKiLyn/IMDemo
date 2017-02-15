//
//  IMTeamManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class IMTeamManager: NSObject {
    
    typealias TeamCreateHandler = (Error?, _ teamID: String?) -> Void
    typealias TeamHandler = (Error?) -> Void
    // MARK: -- Need to modify.
    typealias TeamMemberHandler = (Error?, Array<NIMTeamMember>?) -> Void
    
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
    
    /**
     *  退出群组
     *
     *  @param teamId     群组ID
     *  @param completion 完成后的回调
     */
    
    func quitTeam(teamID: String, completion: @escaping TeamHandler) {
        NIMSDK.shared().teamManager.quitTeam(teamID, completion: completion)
    }
    
    /**
     *  邀请用户入群
     *
     *  @param users       用户ID列表
     *  @param teamId      群组ID
     *  @param postscript  邀请附言
     *  @param completion  完成后的回调
     */
    
    func addUsers(users: Array<String>, teamID: String, postScript: String, completion:@escaping TeamMemberHandler) {
        NIMSDK.shared().teamManager.addUsers(users, toTeam: teamID, postscript: postScript, completion: completion)
    }
    
}

// MARK: To be discussed.
@objc protocol TeamManagerDelegate {
    
    @objc optional
    /**
     *  群组增加回调
     *
     *  @param team 添加的群组
     */
    func onTeamAdded(team:NIMTeam)
}
