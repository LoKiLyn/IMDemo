//
//  GroupViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/10.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    // MARK: - Property
    
    var teamId: String?
    var teamMembers: Array<NIMTeamMember>?
    var messages: Array<NIMMessage> = []
    @IBOutlet weak var titleItem: UINavigationItem!
    @IBOutlet weak var groupMemberView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var messageView: UITableView!
    
    // MARK: - Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        NIMSDK.shared().chatManager.add(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NIMSDK.shared().chatManager.add(self)
    }
    
    deinit {
        NIMSDK.shared().chatManager.remove(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleItem.title = teamId!
        NIMSDK.shared().teamManager.fetchTeamMembers(teamId!) { (error, teamMembers) in
            if error == nil {
                self.teamMembers = teamMembers
                print(teamMembers as Any)
            }else {
                print(error as Any)
            }
        }
    }
    
    
    // MARK: - Events
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        let message = NIMMessage()
        message.text = inputTextField.text
        //清空textField
        self.inputTextField.text = ""
        let session = NIMSession(teamId!, type: NIMSessionType.team)
        do {
            try NIMSDK.shared().chatManager.send(message, to: session)
        } catch {
            print(error)
        }
    }
}

extension GroupViewController: NIMChatManagerDelegate {
    
    func onRecvMessages(_ messages: [NIMMessage]) {
        for message in messages {
            self.messages.append(message)
            print(message.text as Any)
        }
        self.messageView.reloadData()
    }
    
    func send(_ message: NIMMessage, didCompleteWithError error: Error?) {
        if error == nil {
            let alert = UIAlertController(title: "提示", message: "发送成功！", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
            self.messages.append(message)
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.messageView.insertRows(at:[indexPath], with: UITableViewRowAnimation.left)
            self.messageView.reloadData()
        }
        else {
            let alert = UIAlertController(title: "提示", message: "发送失败,\(error)", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

extension GroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == groupMemberView{
            return "群用户"
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == groupMemberView{
            return (teamMembers?.count)!
        }else {
            return messages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == groupMemberView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupMemberCell")
            cell?.textLabel?.text = "UserID: \(teamMembers![indexPath.row].userId!)"
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell") as! ChatCell
            cell.textLabel?.text = messages[indexPath.row].text
            if messages[indexPath.row].senderName == nil {
                cell.textLabel?.textColor = UIColor.red
            }else {
                cell.textLabel?.textColor = UIColor.black
            }
            return cell
        }
    }

}
