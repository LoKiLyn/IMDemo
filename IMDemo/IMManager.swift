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
    
    var loginManager: IMLoginManager = IMLoginManager()
    var teamManager: IMTeamManager = IMTeamManager()
    
    
    /**
     *  切换SDK
     *
     *  @param SDKType   SDK
     */
    func switchSDK(SDKType:SDKType){
        switch SDKType {
        case .Nim:
            loginManager.loginProvider = NIMLoginProvider()
            loginManager.loginModel = NIMLoginModel()
            teamManager.teamProvider = NIMTeamProvider()
            teamManager.teamModel = NIMTeamModel()
        }
    }
}

