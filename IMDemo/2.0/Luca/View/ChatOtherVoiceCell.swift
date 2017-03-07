//
//  ChatMyVoiceCell.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

protocol ChatOtherVoiceCellDelegate {
    func voiceContentDidPressed(indexPath: IndexPath)
}

class ChatOtherVoiceCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var chatContentView: UIControl!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var playingImageView: UIImageView!
    @IBOutlet weak var chatContentViewWidth: NSLayoutConstraint!
    
    private var audioPath: String?
    private var indexPath: IndexPath?
    

    // MARK: Public
    
    public var isPlaying: Bool = false {
        didSet{
            if isPlaying {
                playingImageView.startAnimating()
            } else {
                playingImageView.stopAnimating()
            }
        }
    }
    
    public var delegate: ChatOtherVoiceCellDelegate?
    
    func configWith(messageModel: ChatVoiceModel, indexPath: IndexPath) {
        
        let message = messageModel.message 
        isPlaying = messageModel.isPlaying ?? false
        
        self.indexPath = indexPath
        nickNameLabel.text = message.from
        audioPath = message.audioObject.path
        timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        
        //语音条长度测试用数据
        let duration = message.audioObject.duration!/1000 + 1
        if duration <= 10 {
            chatContentViewWidth.constant = CGFloat(80 + duration * 5)
        } else if duration < 30 && duration > 10 {
            chatContentViewWidth.constant = CGFloat(130 + ((Double(duration) - 10)/10) * 40)
        } else {
            chatContentViewWidth.constant = CGFloat(210)
        }
        self.layoutIfNeeded()
        
        switch message.deliveryState {
        case .MessageDeliveryStateDeliveried:
            timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        case .MessageDeliveryStateFailed:
            timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        case .MessageDeliveryStateDelivering:
            timeLabel.text = "Delivering"
        }
    }
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: Events
    
    @IBAction func voiceContentPressed(_ sender: UIControl) {
        playingImageView.animationImages = [#imageLiteral(resourceName: "OtherVoicePlaying1"),#imageLiteral(resourceName: "OtherVoicePlaying2"),#imageLiteral(resourceName: "OtherVoicePlaying3")]
        playingImageView.animationDuration = 2
        isPlaying = true
        if self.delegate != nil {
            self.delegate?.voiceContentDidPressed(indexPath: self.indexPath!)
        }
    }
    
}
