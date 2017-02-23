//
//  LucaLoginViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/17.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class LucaLoginViewController: UIViewController {

    // MARK: - Property
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let alert = LucaBaseAlertController(nibName: "\(LucaBaseAlertController.self)", bundle: nil)
    
    // MARK: - Events
    
    @IBAction func login(_ sender: UIButton) {
        
        IMManager.shared.loginManager.login(account: "test04", token: "000004") { (error) in
            if error == nil {
                let userName = IMManager.shared.loginManager.currentAccount()
                self.alert.alertTitle = "Welcome to Luka."
                self.alert.contentLabel.text = "----- \(userName) -----"
                self.alert.showOrNot = true
                self.alert.show(inContainter: self)
            } else {
                self.alert.alertTitle = "登录失败"
                self.alert.contentLabel.text = "错误信息：\(error!)"
                self.alert.showOrNot = false
                self.alert.show(inContainter: self)
            }
        }
        
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension LucaLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
