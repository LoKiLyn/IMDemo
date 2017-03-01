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
        case NoSessionID
        case NoTeamID
        case NoMessageImage
        case NoMessageVideoPath
    }
    
    var chatManagerDelegate: ChatManagerDelegate?
    var messageObjectDelegate: IMMessageObject?
//    var customAttachmentDelegate: CustomAttachmentDelegate?
//    var customAttachmentCodingDelegate: CustomAttachmentCodingDelegate?
    
    func converseMessage(message: NIMMessage) -> (IMMessage) {
        let newMessage = IMMessage()
        newMessage.messageID = message.messageId
        newMessage.text = message.text
        newMessage.from = message.from
        newMessage.messageType = IMMessage.MessageType(rawValue: message.messageType.rawValue)!
        newMessage.deliveryState = IMMessage.MessageDeliveryState(rawValue: message.deliveryState.rawValue)
        newMessage.attachmentDownloadState = IMMessage.MessageAttachmentDownloadState(rawValue: message.attachmentDownloadState.rawValue)
        newMessage.isDeleted = message.isDeleted
        switch newMessage.messageType {
        case .MessageTypeImage:
            let originObject = message.messageObject as! NIMImageObject
            newMessage.imageObject = converseImageMessageObject(messageObject: originObject)
        case .MessageTypeAudio:
            let originObject = message.messageObject as! NIMAudioObject
            newMessage.audioObject = converseAudioMessageObject(messageObject: originObject)
        case .MessageTypeCustom:
            let originObject = message.messageObject as! NIMCustomObject
            newMessage.customObject = converseCustomObject(messageObject: originObject)
        default:
            break
        }
        return newMessage
    }
    
    func converseImageMessageObject(messageObject: NIMImageObject) -> (IMImageObject) {
        var imageObject = IMImageObject()
        imageObject.displayName = messageObject.displayName
        imageObject.fileLength = messageObject.fileLength
        imageObject.path = messageObject.path
        imageObject.size = messageObject.size
        imageObject.thumbPath = messageObject.thumbPath
        imageObject.thumbUrl = messageObject.thumbUrl
        imageObject.url = messageObject.url
        return imageObject
    }
    
    func converseAudioMessageObject(messageObject: NIMAudioObject) -> (IMAudioObject) {
        var audioObject = IMAudioObject()
        audioObject.path = messageObject.path
        audioObject.url = messageObject.url
        
        audioObject.duration = messageObject.duration
        
        return audioObject
    }
    
    func converseCustomObject(messageObject: NIMCustomObject) -> (IMCustomObject) {
        var customObject = IMCustomObject()
        customObject.attachment = messageObject.attachment
        return customObject
    }
    
}

extension NIMChatProvider: IMChatProtocol {
    
    internal func sendMessageWithText(model: BaseChatModel, completion: @escaping MessageHandler) {
        let message = NIMMessage()
        message.text = model.messageText
        if model.teamID == nil {
            completion(chatError.NoTeamID)
        } else {
            let session = NIMSession(model.teamID!, type: NIMSessionType.P2P)
            do {
                try NIMSDK.shared().chatManager.send(message, to: session)
            } catch {
                completion(error)
            }
        }
    }
    
    internal func sendMessageWithImage(model: BaseChatModel, completion: @escaping MessageHandler) {
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
        let session = NIMSession(model.teamID!, type: NIMSessionType.P2P)
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            completion(error)
        }
    }
    
    internal func sendMessageWithAudio(model: BaseChatModel, completion: @escaping MessageHandler) {
        let message = NIMMessage()
        if model.messageVideoPath == nil {
            completion(chatError.NoMessageVideoPath)
            return
        }
        let audioObject = NIMAudioObject(sourcePath: model.messageVideoPath!)
        message.messageObject = audioObject
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
    
    internal func sendCustomMessage(model:BaseChatModel, completion: @escaping MessageHandler) {
        
        
        // todo
        
        
        let customObject = NIMCustomObject()
        customObject.attachment = Attachment()
        let message = NIMMessage()
        message.messageObject = customObject
       
        
        
        
        if model.sessionID == nil {
            completion(chatError.NoSessionID)
            return
        }
        
        let session = NIMSession(model.sessionID!, type: NIMSessionType.P2P)
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            completion(error)
        }
    }
    
    internal func setDelegate(delegate: ChatManagerDelegate) {
        NIMSDK.shared().chatManager.add(self)
        self.chatManagerDelegate = delegate
    }
    
    internal func removeDelegate(delegate: ChatManagerDelegate){
        NIMSDK.shared().chatManager.remove(self)
    }
}

extension NIMChatProvider: NIMChatManagerDelegate {
    
    func onRecvMessages(_ messages: [NIMMessage]) {
        if self.chatManagerDelegate != nil {
            var msgArray: Array<IMMessage> = []
            for message in messages {
                let msg = self.converseMessage(message: message)
                msgArray.append(msg)
            }
            self.chatManagerDelegate?.onRecvMsg?(messages: msgArray)
        }
    }
    
    func willSend(_ message: NIMMessage) {
        if self.chatManagerDelegate != nil {
            let msg = self.converseMessage(message: message)
            self.chatManagerDelegate?.willSendMsg?(message: msg)
        }
    }
    
    func send(_ message: NIMMessage, progress: Float) {
        if self.chatManagerDelegate != nil {
            let msg = self.converseMessage(message: message)
            self.chatManagerDelegate!.send?(msg, progress: progress)
        }
    }
    
    func send(_ message: NIMMessage, didCompleteWithError error: Error?) {
        if self.chatManagerDelegate != nil {
            let msg = self.converseMessage(message: message)
            self.chatManagerDelegate!.send?(msg, didCompleteWithError: error)
        }
    }
}
