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
    func sendMessageWithImage(model: BaseChatModel, completion: @escaping MessageHandler)
    func sendMessageWithAudio(model: BaseChatModel, completion: @escaping MessageHandler)
    func sendCustomMessage(model: BaseChatModel, completion: @escaping MessageHandler)
    func setDelegate(delegate: ChatManagerDelegate)
    func removeDelegate(delegate: ChatManagerDelegate)
}

/**
 *  聊天委托
 */
@objc protocol ChatManagerDelegate {
    
    /**
     *  收到消息回调
     *
     *  @param messages 消息列表,内部为IMMessage
     */
    @objc optional func onRecvMsg(messages: Array<IMMessage>)
    
    /**
     *  即将发送消息回调
     *  @discussion 因为发消息之前可能会有个异步的准备过程,所以需要在收到这个回调时才将消息加入到datasource中
     *  @param message 当前发送的消息
     */
    @objc optional func willSendMsg(message: IMMessage)
    
    /**
     *  发送消息进度回调
     *
     *  @param message  当前发送的消息
     *  @param progress 进度
     */
    @objc optional func send(_ message: IMMessage, progress: Float)
    
    /**
     *  发送消息完成回调
     *
     *  @param message 当前发送的消息
     *  @param error   失败原因,如果发送成功则error为nil
     */
    @objc optional func send(_ message: IMMessage, didCompleteWithError error: Error?)
}

/**
 *  自定义消息对象附件协议
 */
protocol CustomAttachmentDelegate {
    
    /**
     *  序列化attachment
     *
     *  @return 序列化后的结果，将用于透传
     */
    func encode() -> (String)
}

protocol CustomAttachmentCodingDelegate {
    func decodeAttachment(_ content: String?) -> (CustomAttachmentDelegate?)
}

class IMChatManager: NSObject {

    internal var chatProvider: IMChatProtocol?
    
    /**
     *  发送文字消息
     *
     *  @param text        文字消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    internal func sendMessageWithText(text: String, teamID: String, completion: @escaping MessageHandler) {
        let model = BaseChatModel()
        model.messageText = text
        model.teamID = teamID
        chatProvider?.sendMessageWithText(model: model, completion: completion)
    }
    
    /**
     *  发送图片消息
     *
     *  @param image        图片消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    internal func sendMessageWithImage(image: UIImage, teamID: String, completion: @escaping MessageHandler) {
        let model = BaseChatModel()
        model.messageImage = image
        model.teamID = teamID
        chatProvider?.sendMessageWithImage(model: model, completion: completion)
    }
    
    /**
     *  发送语音消息
     *
     *  @param filePath    语音消息文件路径
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    internal func sendMessageWithAudio(filePath: String, teamID: String, completion: @escaping MessageHandler) {
        let model = BaseChatModel()
        model.messageVideoPath = filePath
        model.teamID = teamID
        chatProvider?.sendMessageWithAudio(model: model, completion: completion)
    }
    
    /**
     *  发送自定义消息
     *
     *  @param filePath    自定义消息文件路径
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    internal func sendCustomMessage(sessionID: String, customMessage: CustomAttachmentDelegate, completion: @escaping MessageHandler) {
        let model = BaseChatModel()
        model.sessionID = sessionID
        model.customMessage = customMessage
        chatProvider?.sendCustomMessage(model: model, completion: completion)
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
     *  移除代理
     *
     *  @param delegate  消息发送、接收代理
     */
    internal func removeDelegate(delegate: ChatManagerDelegate) {
        chatProvider?.removeDelegate(delegate: delegate)
    }
    
}




