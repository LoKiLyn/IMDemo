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
    var dataSource: Array<BaseChatModel> = []
    
//    var messageArray: Array<IMMessage> = []
    
    /*
     *  当前正在播放的Cell
     */
    var playingModel: ChatVoiceModel?
    
    
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
        
        loadData(count: 10)
        /*
         *  添加聊天键盘代理(ChatInputBoxDelegate)
         */
        self.chatInputBox.delegate = self
        
        /*
         *  添加下拉刷新
         */
        tableView.refreshClosure = {
            self.loadHistory()
        }
        
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
    
    fileprivate func loadData(count: Int) {
        /*
         *  读取会话中最近(limit)条消息
         */
        let messageArray = IMManager.shared.historyManager.messagesInSession(sessionID: IMManager.shared.teamManager.currentTeamID(), limit: count)
        
        for message in messageArray {
            dataSource.append(converseMessageToModel(message: message))
        }
    }
    
    // 读取历史记录
    private func loadHistory() {
        tableView.beginRefreshing()
        if dataSource.count > 0 {
            let appendArray = IMManager.shared.historyManager.messagesInSession(sessionID: IMManager.shared.teamManager.currentTeamID(), limit: 10, message: dataSource.first!.message)
            print(appendArray.count)
            if appendArray.count > 0 {
                for message in appendArray.reversed() {
                    let model = converseMessageToModel(message: message)
                    dataSource.insert(model, at: 0)
                }
                tableView.reloadData()
                tableView.scrollToRow(at: IndexPath(row: (10), section: 0), at: UITableViewScrollPosition.top, animated: false)
            } else {
                //测试用，应使用HUD
                print("没有新数据了！")
            }
            tableView.endRefreshing()
        }
    }
    
    /*
     *  TableView滚动到底部
     */
    fileprivate func scrollToBottom() {
        self.tableView.scrollToRow(at: IndexPath(row: (self.dataSource.count - 1), section: 0), at: UITableViewScrollPosition.bottom, animated: false)
    }
    
    fileprivate func converseMessageToModel(message: IMMessage) -> (BaseChatModel) {
        switch message.messageType {
        case .MessageTypeAudio:
            let model = ChatVoiceModel()
            model.message = message
            model.isPlaying = false
            return model
        default:
            print("Invaild message type.")
            return BaseChatModel()
        }
    }
    
}


extension LukaChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageModel = dataSource[indexPath.row]
        let message = messageModel.message
        switch message.messageType {
        case .MessageTypeAudio:
            if message.from == IMManager.shared.loginManager.currentAccount() {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMyVoiceCell", for: indexPath) as! ChatMyVoiceCell
                cell.configWith(messageModel: messageModel as! ChatVoiceModel, indexPath: indexPath)
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatOtherVoiceCell", for: indexPath) as! ChatOtherVoiceCell
                cell.configWith(messageModel: messageModel as! ChatVoiceModel, indexPath: indexPath)
                cell.delegate = self
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
            dataSource.append(converseMessageToModel(message: message))
        }
        tableView.reloadData()
        scrollToBottom()
    }
    
    func willSendMsg(message: IMMessage) {
        dataSource.append(converseMessageToModel(message: message))
        tableView.reloadData()
        scrollToBottom()
    }
    
    func send(_ message: IMMessage, progress: Float) {
        print(progress)
    }
    
    func send(_ message: IMMessage, didCompleteWithError error: Error?) {
        
        if error == nil {
            for model in dataSource {
                if model.message.messageID == message.messageID {
                    model.message.deliveryState = message.deliveryState
                }
            }
            tableView.reloadData()
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
                self.tableView.scrollToRow(at: IndexPath(row: (self.dataSource.count - 1), section: 0), at: UITableViewScrollPosition.bottom, animated: false)
            }
        }
    }
}


extension LukaChatViewController: ChatMyVoiceCellDelegate, ChatOtherVoiceCellDelegate {
    
    func retryButtonDidPressed(indexPath: IndexPath) {
        //暂用系统alert.
        let alert = UIAlertController(title: "提示", message: "重发该消息？", preferredStyle: UIAlertControllerStyle.alert)
        let resendAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (resendAction) in
            let messageToResend = self.dataSource[indexPath.row].message
            self.dataSource.remove(at: indexPath.row)
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }, completion: { (finish) in
                IMManager.shared.chatManager.resendMessage(sessionID: IMManager.shared.teamManager.currentTeamID(), message: messageToResend, completion: { (error) in
                    if error == nil {
                        print("发送成功")
                    } else {
                        print("发送失败,错误信息:\(error)")
                    }
                })
            })
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(resendAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func voiceContentDidPressed(indexPath: IndexPath) {
        MediaManager.sharedInstance.playWithURL(url: dataSource[indexPath.row].message.audioObject.path ?? "")
        MediaManager.sharedInstance.player?.delegate = self
        
        if playingModel != nil {
            let oldModel = playingModel!
            oldModel.isPlaying = false
            playingModel = dataSource[indexPath.row] as? ChatVoiceModel
            playingModel!.isPlaying = true
        } else {
            playingModel = dataSource[indexPath.row] as? ChatVoiceModel
            playingModel!.isPlaying = true
        }
        tableView.reloadData()
    }
}


extension LukaChatViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playingModel!.isPlaying = false
        tableView.reloadData()
    }
}
