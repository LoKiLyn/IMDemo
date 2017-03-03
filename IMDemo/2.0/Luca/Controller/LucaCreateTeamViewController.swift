//
//  LukaCreateTeamViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/18.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class LukaCreateTeamViewController: UIViewController {
    
    // MARK: - Property
    
    let alert = LukaBaseAlertController.sharedInstance
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Events
    
    @IBAction func createTeam(_ sender: UIButton) {
        IMManager.shared.teamManager.createTeam(users: ["test01", "test04"]) { (error, teamID) in
            if error == nil {
                self.alert.alertTitle = "创建成功"
                self.alert.alertContent = "群组ID为：\(teamID!)"
                self.alert.showOrNot = true
                self.alert.show(inContainter: self)
            } else {
                self.alert.alertTitle = "创建失败"
                self.alert.alertContent = "错误：\(error)"
                self.alert.showOrNot = false
                self.alert.show(inContainter: self)
            }
        }
    }

}
