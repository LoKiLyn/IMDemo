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
        NIMSDK.shared().loginManager.autoLogin("test02", token: "000002")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "showListViewController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.accountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        NIMSDK.shared().loginManager.login(accountTextField.text!, token: passwordTextField.text!) { (error) in
            if error == nil {
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
