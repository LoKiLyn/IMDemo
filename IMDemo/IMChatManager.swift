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
    func setDelegate(delegate: ChatManagerDelegate)
    func removeDelegate(delegate: ChatManagerDelegate)
}

protocol ChatManagerDelegate {
    
    func onRecvMsg(messages: Array<String>)
}

class IMChatManager: NSObject {

    internal var chatProvider: IMChatProtocol?
    internal var chatModel: BaseChatModel?
    
    /**
     *  发送文字消息
     *
     *  @param messageText        文字消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    internal func sendMessageWithText(model: BaseChatModel, completion: @escaping MessageHandler) {
        chatProvider?.sendMessageWithText(model: model, completion: completion)
    }
    
    /**
     *  发送图片消息
     *
     *  @param messageImage        图片消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    internal func sendMessageWithImage(model: BaseChatModel, completion: MessageHandler) {
        chatProvider?.sendMessageWithImage(model: model, completion: completion)
    }
    
    /**
     *  发送语音消息
     *
     *  @param messageVideoPath    语音消息文件路径
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    internal func sendMessageWithAudio(model: BaseChatModel, completion: MessageHandler) {
        chatProvider?.sendMessageWithAudio(model: model, completion: completion)
    }
    
    /**
     *  添加代理
     *
     *  @param delegate  消息发送、接收代理
     */
    internal func addDelegate(delegate: ChatManagerDelegate) {
        chatProvider?.setDelegate(delegate: delegate)
    }
    
    /**
     *  添加代理
     *
     *  @param delegate  消息发送、接收代理
     */
    internal func removeDelegate(delegate: ChatManagerDelegate) {
        chatProvider?.removeDelegate(delegate: delegate)
    }
}




