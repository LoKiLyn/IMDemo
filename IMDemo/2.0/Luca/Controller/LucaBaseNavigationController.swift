//
//  BaseNavigationController.swift
//  Luka
//
//  Created by 宋鹏程 on 2016/12/28.
//  Copyright © 2016年 北京物灵智能科技有限公司. All rights reserved.
//

import UIKit


class LukaBaseNavigationController: UINavigationController {
    
    // MARK: - Property
    
    // MARK: - Lifecycle
    
    override class func initialize () {
        if self == LukaBaseNavigationController.self {
            let backIndicatorImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
            let rightRectImage = backIndicatorImage?.withAlignmentRectInsets(UIEdgeInsetsMake(0, 0, 3.5, 0))
            UINavigationBar.appearance().backIndicatorImage = rightRectImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = rightRectImage
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -53), for: .default)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
