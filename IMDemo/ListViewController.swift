//
//  ListViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/8.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var friendList = NIMSDK.shared().userManager.myFriends()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for user:NIMUser in NIMSDK.shared().userManager.myFriends()! {
            print(user.userId?.description as Any)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        print(friendList?[indexPath.row].description as Any)
        performSegue(withIdentifier: "showChatViewController", sender: self)
    }
    
}
