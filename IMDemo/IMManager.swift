//
//  Manager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/14.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class IMManager: NSObject {
    
    enum SDKType: NSInteger {
        case Nim
    }
    
    static let shared = IMManager()
    
    private override init(){
        super.init()
        switchSDK(SDKType: IMManager.SDKType.Nim)
    }
    
    var currentSDKType: SDKType?
    var loginManager: IMLoginManager = IMLoginManager()
    var teamManager: IMTeamManager = IMTeamManager()
    var chatManager: IMChatManager = IMChatManager()
    var historyManager: IMHistoryManager = IMHistoryManager()
    
    /**
     *  切换SDK
     *
     *  @param SDKType   SDK
     */
    func switchSDK(SDKType:SDKType){
        currentSDKType = SDKType
        switch SDKType {
        case .Nim:
            loginManager.loginProvider = NIMLoginProvider()
            teamManager.teamProvider = NIMTeamProvider()
            chatManager.chatProvider = NIMChatProvider()
            historyManager.historyProvider = NIMHistoryProvider()
        }
    }
    
    /**
     *  初始化SDK
     *
     *  @param appID    应用申请的appKey
     *  @param cerName  推送证书名（optional)
     */
    func register(appID: String, cerName: String?) {
        switch self.currentSDKType! {
        case .Nim:
            NIMSDK.shared().register(withAppID: appID, cerName: cerName)
        }
    }
}

