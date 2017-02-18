//
//  LucaCreateTeamViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/18.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class LucaCreateTeamViewController: UIViewController {
    
    // MARK: - Property
    
    let teamModel = NIMTeamModel()
    let alert = LucaBaseAlertController.sharedInstance
    
    // MARK: - Events
    
    @IBAction func createTeam(_ sender: UIButton) {
        teamModel.initialUsers.append("test01")
        IMManager.shared.teamManager.createTeam(model: teamModel) { (error, teamID) in
            if error == nil {
                self.teamModel.teamID = teamID
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
