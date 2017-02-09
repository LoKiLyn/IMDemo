//
//  ChatViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/8.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - Propertys
    
    var user: NIMUser?
    @IBOutlet weak var titleItem: UINavigationItem!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleItem.title = user?.userId
    }
    
    
    // MARK: - Events
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        let message = NIMMessage()
        let session = NIMSession((user?.userId)!, type: NIMSessionType.P2P)
        do {
           try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            print(error)
        }
    }
    
}
