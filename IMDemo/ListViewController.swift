//
//  ListViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/8.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    //MARK: - Property
    
    var friendList = NIMSDK.shared().userManager.myFriends()
    var selectedIndexPath: IndexPath?
    var myTeams: Array<NIMTeam>?

    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChatViewController" {
            let destination = segue.destination as! ChatViewController
            destination.user = friendList?[(selectedIndexPath?.row)!]
        }
        
        if segue.identifier == "showMyGroupsViewController" {
            let destination = segue.destination as! MyGroupsViewController
            destination.myTeams = myTeams
        }
    }
    
    //MARK: - Events
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        IMManager.shared.loginManager.logout { (error) in
            if error == nil {
                let alert = UIAlertController(title: "提示", message: "注销成功！", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                        self.dismiss(animated: true)
                        self.dismiss(animated: true)
                    })
                })
                print(IMManager.shared.loginManager.isLogined())
            }
            else {
                let alert = UIAlertController(title: "提示", message: "云信注销失败,\(error)", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func createGroupButtonPressed(_ sender: UIButton) {
        IMManager.shared.teamManager.createTeam(users: ["test01","test03"]) { (error, teamId) in
            if error == nil {
                let alert = UIAlertController(title: "提示", message: "创建群成功，群号为\(teamId),群成员:", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "提示", message: "创建群失败,\(error)", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func myTeamButtonPressed(_ sender: UIButton) {
        let team = NIMSDK.shared().teamManager.allMyTeams()
        self.myTeams = team
        self.performSegue(withIdentifier: "showMyGroupsViewController", sender: self)
    }
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (friendList?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell") as! UserInfoCell
        cell.userNameLabel.text = friendList?[indexPath.row].userId
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "showChatViewController", sender: self)
    }
    
}
