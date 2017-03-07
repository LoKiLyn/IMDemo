//
//  BaseHistoryModel.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class IMHistoryModel: NSObject {
    
    /**
     *   会话ID
     */
    var sessionID: String?
    
    /**
     *   查询记录条数
     */
    var limit: Int?
    
    /*
     *  传入的消息(获取传入消息之前的若干条记录时使用)
     */
    var message: IMMessage?
}
