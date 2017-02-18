//
//  NIMTeamProvider.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/16.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class NIMTeamProvider: NSObject,IMTeamProtocol {
    
    enum teamError: Error {
        case NoTeamID
        case NoUsersToAdd
        case NeedDevideID
    }
    
    func createTeam(model:BaseTeamModel, completion:@escaping TeamCreateHandler){
        let teamOption = NIMCreateTeamOption()
        //群名称
        teamOption.name = ""
        //谁可以邀请群成员
        teamOption.inviteMode = NIMTeamInviteMode.all
        //被邀请人验证方式
        teamOption.beInviteMode = NIMTeamBeInviteMode.noAuth
        //群验证方式
        teamOption.joinMode = NIMTeamJoinMode.noAuth
        model.initialUsers.append(NIMSDK.shared().loginManager.currentAccount())
        let users = model.initialUsers
        if model.initialUsers.count <= 1 {
            completion(teamError.NeedDevideID, nil)
            return
        }
        NIMSDK.shared().teamManager.createTeam(teamOption, users: users, completion: completion)
    }
    
    func hasJoinedATeam() -> (Bool){
        return (NIMSDK.shared().teamManager.allMyTeams()?.count)! >= 1
    }
    
    func dismissTeam(model:BaseTeamModel, completion: @escaping TeamHandler){
        let teamID = model.teamID
        if teamID == nil {
            completion(teamError.NoTeamID)
        }else {
            NIMSDK.shared().teamManager.dismissTeam(teamID!, completion: completion)
        }
    }
    
    func quitTeam(model:BaseTeamModel, completion: @escaping TeamHandler){
        let teamID = model.teamID
        if teamID == nil {
            completion(teamError.NoTeamID)
        }else {
            NIMSDK.shared().teamManager.quitTeam(teamID!, completion: completion)
        }
    }
    
    func addUsers(model:BaseTeamModel, completion: @escaping TeamMemberHandler){
        let users = model.usersToAdd
        let teamID = model.teamID
        let postScript = model.postScript
        if users == nil {
            completion(teamError.NoUsersToAdd, nil)
        }else if teamID == nil {
            completion(teamError.NoTeamID, nil)
        }
        NIMSDK.shared().teamManager.addUsers(users!, toTeam: teamID!, postscript: postScript) { (error, members) in
            var memberArray: Array<IMTeamMember>?
            for nimMember in members! {
                let member = IMTeamMember()
                member.userID = nimMember.userId
                member.teamID = nimMember.teamId
                member.invitor = nimMember.invitor
                member.nickName = nimMember.nickname
                member.type = IMTeamMember.TeamMemberType(rawValue: nimMember.type.rawValue)
                memberArray?.append(member)
            }
            completion(error, memberArray)
        }
    }
    
    func currentTeamID() -> (String) {
        let team = NIMSDK.shared().teamManager.allMyTeams()?.first
        return (team?.teamId) ?? ""
    }
}
