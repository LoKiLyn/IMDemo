//
//  LukaChatViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/18.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit
import AVFoundation

class LukaChatViewController: UIViewController {

    
    // MARK: - Property
    
    /*
     *  CellIdentifiers
     */
    let items: [String] = [
        "ChatTimeCell",
        "ChatMyVoiceCell",
        "ChatOtherVoiceCell",
        "ChatOtherVoiceCell",
        "ChatMyVoiceCell",
        ]
    /*
     *  将要发送的语音文件的本地路径
     */
    let audioToSend: String? = NSTemporaryDirectory().appending("audioToSend.aac")
    
    /*
     *  是否已有群组
     */
    var hasTeam: Bool = false
    
    /*
     *  作为数据源的消息集合
     */
    var messageArray: Array<IMMessage> = []
    
    /*
     *  当前正在播放的Cell
     */
    var playingCell: UITableViewCell?
    
    
    @IBOutlet internal weak var tableView: UITableView!
    @IBOutlet weak var chatInputBox: ChatInputBox!
    @IBOutlet weak var chatBoxBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /*
         *  添加聊天代理
         */
        IMManager.shared.chatManager.addDelegate(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         *  判断是否已有群组
         */
        self.hasTeam = IMManager.shared.teamManager.hasJoinedATeam()
        /*
         *  若没有群组，跳转至创建群组Controller
         */
        if !hasTeam {
            self.performSegue(withIdentifier: "presentCreateTeamViewController", sender: self)
        }
        /*
         *  添加聊天键盘代理(ChatInputBoxDelegate)
         */
        self.chatInputBox.delegate = self
        /*  
         *  读取会话中最近(limit)条消息
         */
        messageArray = IMManager.shared.historyManager.messagesInSession(sessionID: IMManager.shared.teamManager.currentTeamID(), limit: 20)
        
        // TestUse: TeamID
        self.navigationItem.title = IMManager.shared.teamManager.currentTeamID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToBottom()
    }
    
    
    // MARK: - Events
    
    @IBAction func memberButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showMemberViewController", sender: self)
    }
    
    
    // MARK: - Private
    
    /*
     *  TableView滚动到底部
     */
    fileprivate func scrollToBottom(){
        self.tableView.scrollToRow(at: IndexPath(row: (self.messageArray.count - 1), section: 0), at: UITableViewScrollPosition.bottom, animated: false)
    }
    
}


extension LukaChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageArray[indexPath.row]
        switch message.messageType {
        case .MessageTypeAudio:
            if message.from == IMManager.shared.loginManager.currentAccount() {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMyVoiceCell") as! ChatMyVoiceCell
                cell.configWith(message: message, indexPath: indexPath)
                cell.delegate = self
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


extension LukaChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension LukaChatViewController: ChatManagerDelegate {
    
    func onRecvMsg(messages: Array<IMMessage>) {
        for message in messages {
            messageArray.append(message)
        }
        tableView.reloadData()
        scrollToBottom()
    }
    
    func willSendMsg(message: IMMessage) {
        messageArray.append(message)
        tableView.reloadData()
        scrollToBottom()
    }
    
    func send(_ message: IMMessage, progress: Float) {
        print(progress)
    }
    
    func send(_ message: IMMessage, didCompleteWithError error: Error?) {
        if error == nil {
            messageArray = IMManager.shared.historyManager.messagesInSession(sessionID: IMManager.shared.teamManager.currentTeamID(), limit: self.messageArray.count)
            tableView.reloadData()
            scrollToBottom()
        } else {
            print(error as Any)
        }
    }
}


extension LukaChatViewController: ChatInputBoxDelegate {
    
    func inputButtonDidTouchDown() {
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
                self.tableView.scrollToRow(at: IndexPath(row: (self.messageArray.count - 1), section: 0), at: UITableViewScrollPosition.bottom, animated: false)
            }
        }
    }
}


extension LukaChatViewController: ChatMyVoiceCellDelegate {
    func voiceContentDidPressed(indexPath: IndexPath) {
        MediaManager.sharedInstance.playWithURL(url: messageArray[indexPath.row].audioObject.path ?? "")
        //添加播放器代理
        MediaManager.sharedInstance.player?.delegate = self

        if playingCell != nil {
            let oldCell = playingCell as! ChatMyVoiceCell
            if playingCell == tableView.cellForRow(at: indexPath) {
                oldCell.animationSwitch = false
                oldCell.animationSwitch = true
            } else {
                oldCell.animationSwitch = false
                playingCell = tableView.cellForRow(at: indexPath)
                let newCell = playingCell as! ChatMyVoiceCell
                newCell.animationSwitch = true
            }
        }
        playingCell = tableView.cellForRow(at: indexPath)
    }
}


extension LukaChatViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let cell = playingCell as! ChatMyVoiceCell
        cell.playingImageView.stopAnimating()
    }
}
