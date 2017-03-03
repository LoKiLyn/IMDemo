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
    
    @IBOutlet internal weak var titleLabel: UILabel!
    @IBOutlet internal weak var contentLabel: UILabel!

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
    
    var alertContent: String {
        get {
            return self.contentLabel.text ?? "content"
        }
        set {
            if let label = self.contentLabel {
                label.text = newValue
            }
        }
    }
    
    var showOrNot: Bool = false

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
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return super.awakeAfter(using: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: Events
    
    @IBAction func submmitButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        switch sourceViewController.self {
        case is LucaLoginViewController:
            if showOrNot {
                sourceViewController?.performSegue(withIdentifier: "showLucaChatViewController", sender: sourceViewController)
            }
        case is LucaCreateTeamViewController:
            sourceViewController?.dismiss(animated: true, completion: nil)
        case is LucaMemberViewController:
            _ = sourceViewController?.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
}
