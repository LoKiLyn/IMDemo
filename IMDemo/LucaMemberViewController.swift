//
//  LucaMemberViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/18.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class LucaMemberViewController: UIViewController {

    // MARK: - Property
    
    let items: [String] = [
        "MemberCell",
        "QuietnessCell",
        ]
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Events
    
    @IBAction func quitButtonPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Private
    
    // MARK: - Navigation
    
}


extension LucaMemberViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.items[indexPath.row])
        
        return cell!
    }
}


extension LucaMemberViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row > 0 {
            self.performSegue(withIdentifier: "presentMemberDeleteViewController", sender: self)
        } else {
            let alert = LucaBaseAlertController(nibName: "\(LucaBaseAlertController.self)", bundle: nil)
            alert.alertTitle = "邀请成员"
            alert.show(inContainter: self)
        }
    }
}
