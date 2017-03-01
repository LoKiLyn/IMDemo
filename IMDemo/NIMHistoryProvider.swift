//
//  NIMHistoryProvider.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class NIMHistoryProvider: NSObject {
    
}

extension NIMHistoryProvider: IMHistoryProtocol {
    internal func messagesInSession(model: BaseHistoryModel) -> Array<IMMessage> {
        let session = NIMSession(model.sessionID ?? "", type: NIMSessionType.team)
        let messages = NIMSDK.shared().conversationManager.messages(in: session, message: nil, limit: model.limit ?? 0)
        
        var newMessages: Array<IMMessage> = []
        for message in messages! {
            let newMessage = NIMChatProvider().converseMessage(message: message)
            newMessages.append(newMessage)
        }
        return newMessages
    }
}
