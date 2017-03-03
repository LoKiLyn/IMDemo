//
//  ChatInputBox.swift
//  Luka
//
//  Created by 宋鹏程 on 2017/1/8.
//  Copyright © 2017年 北京物灵智能科技有限公司. All rights reserved.
//

import UIKit

protocol ChatInputBoxDelegate {
    func inputButtonDidTouchDown()
    func inputButtonDidTouchUpInside()
    func inputButtonDidTouchCancel()
    func moreInputButtonDidPressed()
}

@IBDesignable class ChatInputBox: UIView {
    
    enum InputMode: Int {
        case InputModeVoice
        case InputModeText
    }
    
    // MARK: - Public
    
    var delegate: ChatInputBoxDelegate?
    
    
    // MARK: - Property
    
    var currentInputMode: InputMode = InputMode.InputModeVoice {
        didSet {
            if currentInputMode == InputMode.InputModeVoice {
                inputSwitchButton.setTitle("声音", for: UIControlState.normal)
                voiceButton.isHidden = true
            } else {
                inputSwitchButton.setTitle("文字", for: UIControlState.normal)
                voiceButton.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var inputSwitchButton: UIButton!
    @IBOutlet weak var voiceButton: UIButton!
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initFromNib()
    }
    
    
    // MARK: - Events
    
    @IBAction func voiceButtonTouchDown(_ sender: UIButton) {
        self.delegate?.inputButtonDidTouchDown()
    }
    
    @IBAction func voiceButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.inputButtonDidTouchUpInside()
    }
    
    @IBAction func voiceButtonTouchCancel(_ sender: UIButton) {
        self.delegate?.inputButtonDidTouchCancel()
    }
    
    @IBAction func moreInputButtonPressed(_ sender: UIButton) {
        self.delegate?.moreInputButtonDidPressed()
    }
    
    @IBAction func inputSwitchButtonPressed(_ sender: UIButton) {
        if currentInputMode == InputMode.InputModeText {
            currentInputMode = InputMode.InputModeVoice
        } else {
            currentInputMode = InputMode.InputModeText
        }
    }
    
}


// MARK: - InitFromNib

extension ChatInputBox {
    
    private func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
    
    private var contentView: UIView {
        if self.subviews.first == nil {
            let nib = UINib(nibName: self.nibName(), bundle: Bundle(for: type(of: self)))
            let _contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
            _contentView.translatesAutoresizingMaskIntoConstraints = false
            return _contentView
        } else {
            return self.subviews.first!
        }
    }
    
    private func layoutContentView() {
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    internal func initFromNib() {
        self.addSubview(self.contentView)
        self.layoutContentView()
    }
    
    override func prepareForInterfaceBuilder() {
        
    }
}



    

