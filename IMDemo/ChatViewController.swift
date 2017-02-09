//
//  ChatViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/8.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var user: NIMUser?
    
    @IBOutlet weak var roomLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomLabel.text = user?.userId
    }
}
