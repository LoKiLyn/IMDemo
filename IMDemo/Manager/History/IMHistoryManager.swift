//
//  IMHistoryManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

protocol IMHistoryProtocol {
    func messagesInSession(model: IMHistoryModel) -> Array<IMMessage>
}


class IMHistoryManager: NSObject {
    
    var historyProvider: IMHistoryProtocol?
    
    /**
     *  本地获取最近的若干条消息
     *
     *  @param sessionID      群组ID
     *  @param limit          消息条数
     *  @return               返回的消息数组
     */
    func messagesInSession(sessionID: String, limit: Int) -> Array<IMMessage> {
        let model = IMHistoryModel()
        model.sessionID = sessionID
        model.limit = limit
        return (historyProvider?.messagesInSession(model: model)) ?? []
    }
    
    /**
     *  本地获取某条消息之前的若干条消息
     *
     *  @param sessionID      群组ID
     *  @param limit          消息条数
     *  @param message        指定的消息(获取此消息之前的若干条消息)
     *  @return               返回的消息数组
     */
    func messagesInSession(sessionID: String, limit: Int, message: IMMessage) -> Array<IMMessage> {
        let model = IMHistoryModel()
        model.sessionID = sessionID
        model.limit = limit
        model.message = message
        return (historyProvider?.messagesInSession(model: model)) ?? []
    }
}
