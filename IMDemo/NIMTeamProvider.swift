//
//  NIMTeamProvider.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/16.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class NIMTeamProvider: NSObject,IMTeamProtocol {
    func createTeam(model:BaseTeamModel, completion:@escaping TeamCreateHandler){
        let teamOption = NIMCreateTeamOption()
        //群名称
        teamOption.name = ""
        //谁可以邀请群成员
        teamOption.inviteMode = NIMTeamInviteMode.manager
        //被邀请人验证方式
        teamOption.beInviteMode = NIMTeamBeInviteMode.noAuth
        //群验证方式
        teamOption.joinMode = NIMTeamJoinMode.noAuth
        let users = model.initialUsers
        NIMSDK.shared().teamManager.createTeam(teamOption, users: users!, completion: completion)
    }
    func hasJoinedATeam() -> (Bool){
        return (NIMSDK.shared().teamManager.allMyTeams()?.count)! >= 1

    }
    func dismissTeam(teamID: String, completion: @escaping TeamHandler){
        NIMSDK.shared().teamManager.dismissTeam(teamID, completion: completion)

    }
    func quitTeam(teamID: String, completion: @escaping TeamHandler){
        NIMSDK.shared().teamManager.quitTeam(teamID, completion: completion)
    }
}
