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
// MARK: -- Need to modify.
typealias TeamMemberHandler = (Error?, _ teamMember: Array<IMTeamMember>?) -> Void

protocol IMTeamProtocol: NSObjectProtocol {
    func createTeam(model:BaseTeamModel, completion:@escaping TeamCreateHandler)
    func hasJoinedATeam() -> (Bool)
    func dismissTeam(model:BaseTeamModel, completion: @escaping TeamHandler)
    func quitTeam(model:BaseTeamModel, completion: @escaping TeamHandler)
    func addUsers(model:BaseTeamModel, completion:@escaping TeamMemberHandler)
    func currentTeamID() -> (String)
}

class IMTeamManager: NSObject {

    var teamProvider: IMTeamProtocol?
    var teamModel: BaseTeamModel?
    
    /**
     *  创建群组
     *
     *  @param users 初始添加用户
     *  @param completion 完成回调(error,teamID)
     */
    
    func createTeam(model:BaseTeamModel, completion:@escaping TeamCreateHandler) {
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
    
    func dismissTeam(model:BaseTeamModel, completion: @escaping TeamHandler) {
        teamProvider?.dismissTeam(model: model, completion: completion)
    }
    
    /**
     *  退出群组
     *
     *  @param teamId     群组ID
     *  @param completion 完成后的回调
     */
    
    func quitTeam(model:BaseTeamModel, completion: @escaping TeamHandler) {
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
    
    func addUsers(model:BaseTeamModel, completion:@escaping TeamMemberHandler) {
        teamProvider?.addUsers(model: model, completion: completion)
    }
    
    func currentTeamID() -> (String) {
        return (teamProvider?.currentTeamID())!
    }
    
}
