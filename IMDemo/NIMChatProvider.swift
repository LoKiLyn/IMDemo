//
//  NIMChatProvider.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/17.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class NIMChatProvider: NSObject {
    
    enum chatError: Error {
        case NoTeamID
        case NoMessageImage
        case NoMessageVideoPath
    }
    
    var delegate: ChatManagerDelegate?
}

extension NIMChatProvider: IMChatProtocol {
    
    internal func sendMessageWithText(model: BaseChatModel, completion: @escaping MessageHandler) {
        let message = NIMMessage()
        message.text = model.messageText
        if model.teamID == nil {
            completion(chatError.NoTeamID)
        } else {
            let session = NIMSession(model.teamID!, type: NIMSessionType.team)
            do {
                try NIMSDK.shared().chatManager.send(message, to: session)
            } catch {
                completion(error)
            }
        }
    }
    
    internal func sendMessageWithImage(model: BaseChatModel, completion: MessageHandler) {
        let message = NIMMessage()
        if model.messageImage == nil {
            completion(chatError.NoMessageImage)
            return
        }
        let imageObject = NIMImageObject(image: model.messageImage!)
        message.messageObject = imageObject
        if model.teamID == nil {
            completion(chatError.NoTeamID)
            return
        }
        let session = NIMSession(model.teamID!, type: NIMSessionType.team)
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            completion(error)
        }
    }
    
    internal func sendMessageWithAudio(model: BaseChatModel, completion: MessageHandler) {
        let message = NIMMessage()
        if model.messageVideoPath == nil {
            completion(chatError.NoMessageVideoPath)
            return
        }
        let videoObject = NIMVideoObject(sourcePath: model.messageVideoPath!)
        message.messageObject = videoObject
        if model.teamID == nil {
            completion(chatError.NoTeamID)
            return
        }
        let session = NIMSession(model.teamID!, type: NIMSessionType.team)
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            completion(error)
        }
    }
    
    internal func setDelegate(delegate: ChatManagerDelegate) {
        NIMSDK.shared().chatManager.add(self)
        self.delegate = delegate
    }
    
    internal func removeDelegate(delegate: ChatManagerDelegate){
        NIMSDK.shared().chatManager.remove(self)
    }

}

extension NIMChatProvider: NIMChatManagerDelegate {
    
    func onRecvMessages(_ messages: [NIMMessage]) {
        if self.delegate != nil {
            // processedxx
            var msgArray: Array<String> = []
            for message in messages {
                msgArray.append(message.text!)
            }
            self.delegate?.onRecvMsg(messages: msgArray)
        }
    }
}
