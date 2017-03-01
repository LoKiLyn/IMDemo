//
//  AppDelegate.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/8.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IMManager.shared.register(appID: APPKEY, cerName: nil)
        NIMSDK.shared().loginManager.add(self as NIMLoginManagerDelegate)
        IMBaseObject.registerCustomDecoder(decoder: IMBaseObject()) // todo
        return true
    }

}

extension AppDelegate: NIMLoginManagerDelegate {
    func onLogin(_ step: NIMLoginStep) {

    }
}

