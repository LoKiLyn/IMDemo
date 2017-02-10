//
//  GroupViewController.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/10.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    var teamId: String?
    @IBOutlet weak var titleItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleItem.title = teamId!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
