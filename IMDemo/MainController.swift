//
//  ViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/8.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    // MARK: - Property
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accountTextField.text = "test02"
        self.passwordTextField.text = "000002"
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.accountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        Manager.shared.login(login: accountTextField.text!, token: passwordTextField.text!) { (error) in
            if error == nil {
                print(NIMSDK.shared().loginManager.isLogined())
                let alert = UIAlertController(title: "提示", message: "云信登录成功，您好，\(NIMSDK.shared().loginManager.currentAccount())", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                        self.dismiss(animated: true)
                        self.performSegue(withIdentifier: "showListViewController", sender: self)
                    })
                })
            }
            else{
                let alert = UIAlertController(title: "提示", message: "云信登录失败,\(error)", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }

}
