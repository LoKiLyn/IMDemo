//
//  IMTeamManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

typealias TeamCreateHandler = (Error?, _ teamID: String?) -> Void
typealias TeamHandler = (Error?) -> Void
typealias TeamMemberHandler = (Error?, _ teamMember: Array<IMTeamMember>?) -> Void

protocol IMTeamProtocol: NSObjectProtocol {
    func createTeam(model: IMTeamModel, completion:@escaping TeamCreateHandler)
    func hasJoinedATeam() -> (Bool)
    func dismissTeam(model: IMTeamModel, completion: @escaping TeamHandler)
    func quitTeam(model: IMTeamModel, completion: @escaping TeamHandler)
    func addUsers(model: IMTeamModel, completion:@escaping TeamMemberHandler)
    func currentTeamID() -> (String)
}

class IMTeamManager: NSObject {

    var teamProvider: IMTeamProtocol?
    
    /**
     *  创建群组
     *
     *  @param users 初始添加用户账号（包括创建群组的用户！所以数组元素个数>=2 !）
     *  @param completion 完成回调(error,teamID)
     */
    func createTeam(users: Array<String>, completion:@escaping TeamCreateHandler) {
        let model = IMTeamModel()
        model.initialUsers = users
        teamProvider?.createTeam(model: model, completion: completion)
    }
    
    
    /**
     *  是否已有群组
     *
     *  @return 当前群组状态
     */
    func hasJoinedATeam() -> (Bool) {
        return teamProvider!.hasJoinedATeam()
    }
    
    /**
     *  解散群组
     *
     *  @param teamId      群组ID
     *  @param completion  完成后的回调
     */
    func dismissTeam(teamID: String, completion: @escaping TeamHandler) {
        let model = IMTeamModel()
        model.teamID = teamID
        teamProvider?.dismissTeam(model: model, completion: completion)
    }
    
    /**
     *  退出群组
     *
     *  @param teamId     群组ID
     *  @param completion 完成后的回调
     */
    func quitTeam(teamID: String, completion: @escaping TeamHandler) {
        let model = IMTeamModel()
        model.teamID = teamID
        teamProvider?.quitTeam(model: model, completion: completion)
    }
    
    /**
     *  邀请用户入群
     *
     *  @param users       用户ID列表
     *  @param teamId      群组ID
     *  @param postscript  邀请附言
     *  @param completion  完成后的回调
     */
    func addUsers(users: Array<String>, teamID: String, postscript: String, completion:@escaping TeamMemberHandler) {
        let model = IMTeamModel()
        model.usersToAdd = users
        model.teamID = teamID
        model.postScript = postscript
        teamProvider?.addUsers(model: model, completion: completion)
    }
    
    /**
     *  当前群组ID
     *
     *  @return 群组ID
     */
    func currentTeamID() -> (String) {
        return teamProvider?.currentTeamID() ?? ""
    }
    
}
