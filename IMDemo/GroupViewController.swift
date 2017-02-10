//
//  GroupViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/10.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    var teamId: String?
    var teamMembers: Array<NIMTeamMember>?
    @IBOutlet weak var titleItem: UINavigationItem!
    @IBOutlet weak var groupMemberView: UITableView!
    
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
    
}

extension GroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "群用户"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (teamMembers?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupMemberCell")
        cell?.textLabel?.text = "UserID: \(teamMembers![indexPath.row].userId!)"
        return cell!
    }

}
