//
//  IMChatManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/15.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class IMChatManager: NSObject {
    typealias MessageHandler = (Error?) -> Void
    
    /**
     *  发送文字消息
     *
     *  @param text        文字消息
     *  @param teamID      群组ID
     *  @param completion  完成后的回调
     */
    
    func sendMessageWithText(text: String, teamID: String, completion: MessageHandler) {
        let message = NIMMessage()
        message.text = text
        let session = NIMSession(teamID, type: NIMSessionType.team)
        // MARK: - Remain to be verified.
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            completion(error)
        }
    }
    
    func sendMessageWithImage(image: UIImage, teamID: String, completion: MessageHandler) {
        let imageObject = NIMImageObject(image: image)
        let message = NIMMessage()
        message.messageObject = imageObject
        let session = NIMSession(teamID, type: NIMSessionType.team)
        // MARK: - Remain to be verified.
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            completion(error)
        }
    }
    
    func sendMessageWithAudio(filePath: String, toSessionID: String, completion: MessageHandler) {
        let videoObject = NIMVideoObject(sourcePath: filePath)
        let message = NIMMessage()
        message.messageObject = videoObject
        let session = NIMSession(toSessionID, type: NIMSessionType.team)
        // MARK: - Remain to be verified.
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            completion(error)
        }
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

