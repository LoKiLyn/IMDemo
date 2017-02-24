//
//  LucaChatViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/18.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class LucaChatViewController: UIViewController {

    
    // MARK: - Property
    
    let items: [String] = [
        "ChatTimeCell",
        "ChatMyVoiceCell",
        "ChatOtherVoiceCell",
        "ChatOtherVoiceCell",
        "ChatMyVoiceCell",
        ]
    var hasTeam: Bool = false
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hasTeam = IMManager.shared.teamManager.hasJoinedATeam()
        if !hasTeam {
            self.performSegue(withIdentifier: "presentCreateTeamViewController", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Events
    
    @IBAction func memberButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showMemberViewController", sender: self)
    }
    
    // MARK: - Private
    
    // MARK: - Navigation
    
}


extension LucaChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.items[indexPath.row])
        return cell!
    }
}


extension LucaChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
