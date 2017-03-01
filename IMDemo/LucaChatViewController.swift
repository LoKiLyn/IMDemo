//
//  LucaChatViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/18.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

//protocol LucaChatViewControllerDelegate {
//    func chatTableViewDidSelectIndexPath(indexPath: IndexPath)
//}


class LucaChatViewController: UIViewController {

    
    // MARK: - Property
    
    let items: [String] = [
        "ChatTimeCell",
        "ChatMyVoiceCell",
        "ChatOtherVoiceCell",
        "ChatOtherVoiceCell",
        "ChatMyVoiceCell",
        ]
    var hasTeam: Bool = false
    var audioToSend: String?
    var messageArray: Array<IMMessage> = []
//    var delegate: LucaChatViewControllerDelegate?
    
    @IBOutlet internal weak var tableView: UITableView!
    @IBOutlet weak var chatInputBox: ChatInputBox!
    
    @IBOutlet weak var chatBoxBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        IMManager.shared.chatManager.addDelegate(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //判断是否已有群组
        self.hasTeam = IMManager.shared.teamManager.hasJoinedATeam()
        if !hasTeam {
            self.performSegue(withIdentifier: "presentCreateTeamViewController", sender: self)
        }
        //添加聊天键盘代理
        self.chatInputBox.delegate = self
        //读取会话中最近10条消息
        self.navigationItem.title = IMManager.shared.teamManager.currentTeamID()
        messageArray = IMManager.shared.historyManager.messagesInSession(sessionID: IMManager.shared.teamManager.currentTeamID(), limit: 20)
        
        //tableView滚动到底部
        self.tableView.scrollToRow(at: IndexPath(row: messageArray.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
        //测试用打印messageInfo
        for message in messageArray {
            print(message.audioObject?.path as Any)
            print(message.audioObject?.duration as Any)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Events
    
    @IBAction func memberButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showMemberViewController", sender: self)
        
    }
    
    // MARK: - Private
    
    internal func scrollToBottom(){
        self.tableView.scrollToRow(at: IndexPath(row: (self.messageArray.count - 1), section: 0), at: UITableViewScrollPosition.bottom, animated: false)
    }
    
    // MARK: - Navigation
    
}


extension LucaChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageArray[indexPath.row]
        switch message.messageType {
        case .MessageTypeAudio:
            if message.from == IMManager.shared.loginManager.currentAccount() {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMyVoiceCell") as! ChatMyVoiceCell
                cell.configWith(message: message)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatOtherVoiceCell") as! ChatOtherVoiceCell
                cell.configWith(message: message)
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTimeCell")
            return cell!
            
        }
    }
}



extension LucaChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = messageArray[indexPath.row].audioObject?.path
        MediaManager.sharedInstance.playWithURL(url: url!)
    }
}

extension LucaChatViewController: ChatManagerDelegate {
    
    func onRecvMsg(messages: Array<IMMessage>) {
        for message in messages {
            self.messageArray.append(message)
        }
        self.tableView.reloadData()
        scrollToBottom()
    }
}

extension LucaChatViewController: ChatInputBoxDelegate {
    
    func inputButtonDidTouchDown() {
        audioToSend = NSTemporaryDirectory().appending("test.aac")
        MediaManager.sharedInstance.startRecordToURL(url: audioToSend)
    }
    
    func inputButtonDidTouchUpInside() {
        MediaManager.sharedInstance.stop()
        IMManager.shared.chatManager.sendMessageWithAudio(filePath: audioToSend!, teamID: IMManager.shared.teamManager.currentTeamID()) { (error) in
            if error == nil {
                print("发送成功")
            } else {
                print(error as Any)
            }
        }
    }
    
    func inputButtonDidTouchCancel() {
        MediaManager.sharedInstance.stop()
        //清理录制下来的文件. ToDo
    }
    
    func moreInputButtonDidPressed() {
        if self.chatBoxBottomConstraint.constant == 0 {
            UIView.animate(withDuration: 0.25) {
                self.chatBoxBottomConstraint.constant = -172
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.25) {
                self.chatBoxBottomConstraint.constant = 0
                self.view.layoutIfNeeded()
                // 注意先后顺序.
                self.tableView.scrollToRow(at: IndexPath(row: (self.messageArray.count - 1), section: 0), at: UITableViewScrollPosition.bottom, animated: false)
            }
        }
    }
}

