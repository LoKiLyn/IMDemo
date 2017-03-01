//
//  IMHistoryManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

protocol IMHistoryProtocol {
    func messagesInSession(model: BaseHistoryModel) -> Array<IMMessage>
}


class IMHistoryManager: NSObject {
    
    var historyProvider: IMHistoryProtocol?
    
    func messagesInSession(sessionID: String, limit: Int) -> Array<IMMessage> {
        let model = BaseHistoryModel()
        model.sessionID = sessionID
        model.limit = limit
        return (historyProvider?.messagesInSession(model: model)) ?? []
    }
    
}
