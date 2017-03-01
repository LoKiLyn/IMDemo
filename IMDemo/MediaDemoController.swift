//
//  MediaDemoController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class MediaDemoController: UIViewController {
    
    var recordURL: String = "/Users/xiaobai/Desktop/test.aac"
    var audioPath: String?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        IMManager.shared.chatManager.addDelegate(delegate: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        IMManager.shared.chatManager.addDelegate(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func recordButtonTouchUpInside(_ sender: UIButton) {
//        MediaManager.sharedInstance.startRecordToURL(url: recordURL)
    }
    
    @IBAction func recordButtonTouchUpOutside(_ sender: UIButton) {
//        MediaManager.sharedInstance.stop()
        IMManager.shared.chatManager.sendMessageWithAudio(filePath: recordURL, teamID: "test01") { (error) in
            if error == nil {
                print("发送成功")
            } else {
                print(error as Any)
            }
        }
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        MediaManager.sharedInstance.playWithURL(url: audioPath ?? "")
    }

}

extension MediaDemoController: ChatManagerDelegate {
    func onRecvMsg(messages: Array<IMMessage>) {
        for message in messages {
            switch  message.messageType {
            case .MessageTypeAudio:
                self.audioPath = message.audioObject?.path
                print(self.audioPath as Any)
            default:
                break
            }
        }
    }
}
