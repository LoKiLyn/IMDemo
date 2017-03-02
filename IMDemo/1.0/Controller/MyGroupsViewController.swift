//
//  MyGroupsViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/10.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class MyGroupsViewController: UIViewController {

    var myTeams: Array<NIMTeam>?
    var selectedTeamId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGroupViewController" {
            let destination = segue.destination as! GroupViewController
            destination.teamId = self.selectedTeamId
        }
    }
    
}

extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.myTeams?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as! GroupListCell
        cell.teamIdLabel.text = "群ID: \(myTeams![indexPath.row].teamId!)"
        return cell
    }

}

extension MyGroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.selectedTeamId = myTeams?[indexPath.row].teamId
        self.performSegue(withIdentifier: "showGroupViewController", sender: self)
    }

}
