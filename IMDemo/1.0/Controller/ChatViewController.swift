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
    var messages: Array<NIMMessage> = []
    var result: String?
    @IBOutlet weak var titleItem: UINavigationItem!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var imageMessageView: UIImageView!
    @IBOutlet weak var fileInfoLabel: UILabel!
    @IBOutlet weak var customInfoLabel: UILabel!
    
    
    // MARK: - LifeCycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        IMManager.shared.chatManager.addDelegate(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleItem.title = user?.userId
    }
    
    deinit {
        IMManager.shared.chatManager.removeDelegate(delegate: self)
    }
    
    
    // MARK: - Events
    
    @IBAction func sendImageButtonPressed(_ sender: UIButton) {
        let image = UIImage(named: "CameraEntrance")
        IMManager.shared.chatManager.sendMessageWithImage(image: image!, teamID: (user?.userId)!) { (error) in
            if error == nil {
                print("发送成功")
            } else {
                print("发送失败:\(error)")
            }
        }
    }
    
    @IBAction func sendTextButtonPressed(_ sender: UIButton) {
        let text = self.inputTextField.text ?? ""
        IMManager.shared.chatManager.sendMessageWithText(text: text, teamID: (user?.userId)!) { (error) in
            if error == nil {
                print("发送成功")
            } else {
                print("发送失败:\(error)")
            }
        }
    }
    
    @IBAction func sendFileButtonPressed(_ sender: UIButton) {
        let filePath = "/Users/xiaobai/Desktop/test.mp3"
        IMManager.shared.chatManager.sendMessageWithAudio(filePath: filePath, teamID:(user?.userId)!) { (error) in
            if error == nil {
                print("发送成功")
            } else {
                print("发送失败:\(error)")
            }
        }
    }
    
    @IBAction func sendCustomButtonPressed(_ sender: UIButton) {
        IMManager.shared.chatManager.sendCustomMessage(sessionID: (user?.userId)!, customMessage: "abcdefg") { (error) in
            if error == nil {
                print("发送成功")
            } else {
                print("发送失败:\(error)")
            }
        }
    }
}


extension ChatViewController: ChatManagerDelegate {
    
    func onRecvMsg(messages: Array<IMMessage>) {
        for message in messages {
            switch message.messageType {
            case .MessageTypeText:
                print(message.text as Any)
            case .MessageTypeAudio:
                print(message.audioObject)
            case .MessageTypeImage:
                print(message.imageObject.url as Any)
            case .MessageTypeCustom:
                print(message.customObject.content as Any)
            default:
                break
            }
        }
    }
}
