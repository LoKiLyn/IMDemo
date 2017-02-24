//
//  IMTeamMember.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/16.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

/**
 *  群成员信息
 */
class IMTeamMember: NSObject {
    
    enum TeamMemberType: NSInteger{
        /**
         *  普通群员
         */
        case TeamMemberTypeNormal = 0
        /**
         *  群拥有者
         */
        case TeamMemberTypeOwner = 1
        /**
         *  群管理员
         */
        case TeamMemberTypeManager = 2
        /**
         *  申请加入用户
         */
        case TeamMemberTypeApply   = 3
    }
    
    /**
     *  群ID
     */
    var teamID: String?
    
    /**
     *  群成员ID
     */
    var userID: String?
    
    /**
     *  邀请者ID
     *  @dicusssion 此字段仅当该成员为自己时有效。不允许查看其他群成员的邀请者
     */
    var invitor: String?
    
    /**
     *  群成员类型
     */
    var type: TeamMemberType?
    
    /**
     *  群昵称
     */
    var nickName: String?
    
    
}
