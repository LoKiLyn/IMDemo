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
    func sendMessageWithText(model: IMChatModel, completion: @escaping MessageHandler)
    func sendMessageWithImage(model: IMChatModel, completion: @escaping MessageHandler)
    func sendMessageWithAudio(model: IMChatModel, completion: @escaping MessageHandler)
    func sendCustomMessage(model: IMChatModel, completion: @escaping MessageHandler)
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

class IMChatManager: NSObject {

    var chatProvider: IMChatProtocol?
    
    /**
     *  发送文字消息
     *
     *  @param text        文字消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    func sendMessageWithText(text: String, teamID: String, completion: @escaping MessageHandler) {
        let model = IMChatModel()
        model.messageText = text
        model.sessionID = teamID
        chatProvider?.sendMessageWithText(model: model, completion: completion)
    }
    
    /**
     *  发送图片消息
     *
     *  @param image        图片消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    func sendMessageWithImage(image: UIImage, teamID: String, completion: @escaping MessageHandler) {
        let model = IMChatModel()
        model.messageImage = image
        model.sessionID = teamID
        chatProvider?.sendMessageWithImage(model: model, completion: completion)
    }
    
    /**
     *  发送语音消息
     *
     *  @param filePath    语音消息文件路径
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    func sendMessageWithAudio(filePath: String, teamID: String, completion: @escaping MessageHandler) {
        let model = IMChatModel()
        model.messageVideoPath = filePath
        model.sessionID = teamID
        chatProvider?.sendMessageWithAudio(model: model, completion: completion)
    }
    
    /**
     *  发送自定义消息
     *
     *  @param filePath    自定义消息文件路径
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    func sendCustomMessage(sessionID: String, customMessage: NIMCustomAttachment, completion: @escaping MessageHandler) {
        let model = IMChatModel()
        model.sessionID = sessionID
        model.customMessage = customMessage
        chatProvider?.sendCustomMessage(model: model, completion: completion)
    }
    
    /**
     *  添加代理
     *
     *  @param delegate  消息发送、接收代理
     */
    func addDelegate(delegate: ChatManagerDelegate) {
        chatProvider?.setDelegate(delegate: delegate)
    }
    
    /**
     *  移除代理
     *
     *  @param delegate  消息发送、接收代理
     */
    func removeDelegate(delegate: ChatManagerDelegate) {
        chatProvider?.removeDelegate(delegate: delegate)
    }
    
}




