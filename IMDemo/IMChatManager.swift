//
//  IMChatManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

typealias MessageHandler = (Error?) -> Void

protocol IMChatProtocol: NSObjectProtocol {
    func sendMessageWithText(model: BaseChatModel, completion: @escaping MessageHandler)
    func sendMessageWithImage(model: BaseChatModel, completion: MessageHandler)
    func sendMessageWithAudio(model: BaseChatModel, completion: MessageHandler)
}

class IMChatManager: NSObject {
    
    var chatProvider: IMChatProtocol?
    var chatModel: BaseChatModel?
    
    /**
     *  发送文字消息
     *
     *  @param text        文字消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    
    func sendMessageWithText(model: BaseChatModel, completion: @escaping MessageHandler) {
        chatProvider?.sendMessageWithText(model: model, completion: completion)
    }
    
    func sendMessageWithImage(model: BaseChatModel, completion: MessageHandler) {
        chatProvider?.sendMessageWithImage(model: model, completion: completion)
    }
    
    func sendMessageWithAudio(model: BaseChatModel, completion: MessageHandler) {
        chatProvider?.sendMessageWithAudio(model: model, completion: completion)
    }
}

@objc protocol ChatManagerDelegate {
    @objc optional
    /**
     *  即将发送消息回调
     *  @discussion 因为发消息之前可能会有个异步的准备过程,所以需要在收到这个回调时才将消息加入到datasource中
     *  @param message 当前发送的消息
     */
    func willSendMessage(message:NIMMessage)
    
}

