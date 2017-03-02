//
//  Extensions.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/13.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import Foundation

extension UIAlertController {
    func createAlertWithAction(title: String, message: String, style: UIAlertControllerStyle, actionTitle: String, actionStyle: UIAlertActionStyle)->(UIAlertController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
    
}
