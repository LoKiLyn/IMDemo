//
//  InterfaceTestController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/16.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class InterfaceTestController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var interfaceArray: Array<Array<String>> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData(){
        let url = Bundle.main.url(forResource: "Interface", withExtension: "plist")
        // 加载 plist 文件
        let interfaceArr = NSMutableArray(contentsOf: url!)
        self.interfaceArray = interfaceArr?.copy() as! Array<Array<String>>
    }
}

extension InterfaceTestController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "LoginManager"
        case 1:
            return "TeamManager"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.interfaceArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interfaceArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstLevel")
        cell?.textLabel?.text = interfaceArray[indexPath.section][indexPath.row]
        return cell!
    }
}

extension InterfaceTestController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = NIMLoginModel()
        model.account = "test02"
        model.token = "000002"
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                IMManager.shared.loginManager.login(model: model) { (error) in
                    if error == nil {
                        let alert = UIAlertController().createAlertWithAction(title: "提示", message: "云信登录成功，您好，\(IMManager.shared.loginManager.currentAccount())", style: UIAlertControllerStyle.alert, actionTitle: "OK", actionStyle: UIAlertActionStyle.cancel)
                        self.present(alert, animated: true)
                    }
                    else{
                        let alert = UIAlertController().createAlertWithAction(title: "提示", message: "云信登录失败,\(error)", style:  UIAlertControllerStyle.alert, actionTitle: "OK", actionStyle: UIAlertActionStyle.cancel)
                        self.present(alert, animated: true)
                    }
                }
            break
            case 1:
                IMManager.shared.loginManager.autologin(model: model, completion: { (error) in
                    if error == nil {
                        let alert = UIAlertController().createAlertWithAction(title: "提示", message: "自动登录成功，您好，\(IMManager.shared.loginManager.currentAccount())", style: UIAlertControllerStyle.alert, actionTitle: "OK", actionStyle: UIAlertActionStyle.cancel)
                        self.present(alert, animated: true)
                    }
                    else{
                        let alert = UIAlertController().createAlertWithAction(title: "提示", message: "自动登录失败,\(error)", style:  UIAlertControllerStyle.alert, actionTitle: "OK", actionStyle: UIAlertActionStyle.cancel)
                        self.present(alert, animated: true)
                    }
                })
            break
            case 2:
                IMManager.shared.loginManager.logout { (error) in
                    if error == nil {
                        let alert = UIAlertController(title: "提示", message: "注销成功！", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true)
                        print(IMManager.shared.loginManager.isLogined())
                    }
                    else {
                        let alert = UIAlertController(title: "提示", message: "注销失败,\(error)", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true)
                    }
                }
            break
            case 3:
                let alert = UIAlertController(title: "提示", message: "当前登陆账号为：\(IMManager.shared.loginManager.currentAccount())", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            break
            case 4:
                let alert = UIAlertController(title: "提示", message: "当前登陆状态：\(IMManager.shared.loginManager.isLogined())", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            break
            default: break
            }
            break
  
        break
        default: break
        }

    }
}
