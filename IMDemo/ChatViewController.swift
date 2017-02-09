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
    @IBOutlet weak var inputTextField: UITextField!
    
    // MARK: - LifeCycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        NIMSDK.shared().chatManager.add(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NIMSDK.shared().chatManager.add(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleItem.title = user?.userId
    }
    
    deinit {
        NIMSDK.shared().chatManager.remove(self)
    }
    
    // MARK: - Events
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        let message = NIMMessage()
        message.text = inputTextField.text
        //清空textField
        self.inputTextField.text = ""
        let session = NIMSession((user?.userId)!, type: NIMSessionType.P2P)
        do {
           try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            print(error)
        }
    }
    
}

extension ChatViewController: NIMChatManagerDelegate {
    
    func onRecvMessages(_ messages: [NIMMessage]) {
        for message in messages {
            print(message.text as Any)
        }
    }
    
    func send(_ message: NIMMessage, didCompleteWithError error: Error?) {
        if error == nil {
            let alert = UIAlertController(title: "提示", message: "发送成功！", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "提示", message: "发送失败,\(error)", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
