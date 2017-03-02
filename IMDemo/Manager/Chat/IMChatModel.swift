//
//  BaseChatModel.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/17.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class IMChatModel: NSObject {
    
    /**
     *  文字消息
     */
    var messageText: String = ""
    
    /**
     *  图片消息
     */
    var messageImage: UIImage?
    
    /**
     *  语音消息
     */
    var messageVideoPath: String?
    
    /**
     *  会话ID（群聊为teamId，p2p聊天为userID)
     */
    var sessionID: String?
    
    /**
     *  Remain To Be Done
     */
    var customMessage: Any?
    
}
