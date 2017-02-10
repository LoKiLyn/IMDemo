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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.myTeams?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell")
        cell?.textLabel?.text = "群组ID: \(myTeams?[indexPath.row].teamId)"
        return cell!
    }

}
