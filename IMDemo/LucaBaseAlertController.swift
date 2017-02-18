//
//  BaseAlertController.swift
//  Luka
//
//  Created by 宋鹏程 on 2017/1/13.
//  Copyright © 2017年 北京物灵智能科技有限公司. All rights reserved.
//


import UIKit


class LucaBaseAlertController: UIViewController {
    
    //MARK: - Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var str = "1234"
    // MARK: - Public
    
    var alertTitle: String {
        get {
            return self.titleLabel.text ?? "title"
        }
        set {
            if let label = self.titleLabel {
                label.text = newValue
            }
        }
        
    }
    
    
    class var sharedInstance: LucaBaseAlertController {
        struct Static {
            static let instance = LucaBaseAlertController(nibName: "\(LucaBaseAlertController.self)", bundle: nil)
        }
        return Static.instance
    }
    
    func show(inContainter controller: UIViewController?) {
        self.sourceViewController = controller
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        controller?.present(self, animated: true, completion: nil)
    }
    
    
    // MARK: - Property
    
    var sourceViewController: UIViewController?

    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        print("][][][][][][][")
        return super.awakeAfter(using: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        loadView()
        print("asdfasdfasdfasdfasdfasdfasdf")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("============")
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Events
    
    @IBAction func submmitButtonPressed(_ sender: UIButton) {
        self.titleLabel.text = "9273641028367410234"
    }
    
}
