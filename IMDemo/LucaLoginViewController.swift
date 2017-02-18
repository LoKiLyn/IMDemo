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
        
        let loginModel = NIMLoginModel()
        loginModel.account = accountTextField.text
        loginModel.token = passwordTextField.text
        
        IMManager.shared.loginManager.login(model: loginModel) { (error) in
            
             //LucaBaseAlertController.sharedInstance
            
            if error == nil {
                let userName = NIMSDK.shared().loginManager.currentAccount()
//                alert.contentLabel.text = "Welcome：\(userName)"
                self.alert.show(inContainter: self)
                print(userName)
            } else {
//                alert.titleLabel.text = "登录失败"
//                alert.contentLabel.text = "错误信息：\(error!)"
//                self.alert.alertTitle = "asdasdf"
                self.alert.str = "asdfasdfasdfasdfasdfasdfasiofuwyeqriq78t2ecfkjahsgd"
                print(self.alert.str)
                self.alert.show(inContainter: self)
                print(error!)
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
        return textField.endEditing(true)
    }
}
