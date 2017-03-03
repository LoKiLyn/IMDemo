//
//  ChatMyVoiceCell.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

protocol ChatMyVoiceCellDelegate {
    func voiceContentDidPressed(indexPath: IndexPath)
}

class ChatMyVoiceCell: UITableViewCell {

    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var chatContentView: UIControl!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var playingImageView: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    
    private var audioPath: String?
    private var indexPath: IndexPath?
    var delegate: ChatMyVoiceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func voiceContentPressed(_ sender: UIControl) {
        
        self.playingImageView.animationImages = [#imageLiteral(resourceName: "MyVoicePlaying1"),#imageLiteral(resourceName: "MyVoicePlaying2"),#imageLiteral(resourceName: "MyVoicePlaying3")]
        self.playingImageView.animationDuration = 2
        self.playingImageView.startAnimating()
        
        if self.delegate != nil {
            self.delegate?.voiceContentDidPressed(indexPath: self.indexPath!)
        }
    }
    
    func configWith(message: IMMessage, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.nickNameLabel.text = message.from
        self.audioPath = message.audioObject.path
        self.timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        switch message.deliveryState {
        case .MessageDeliveryStateDeliveried:
            self.retryButton.isHidden = true
            self.timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        case .MessageDeliveryStateFailed:
            self.retryButton.isHidden = false
            self.timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        case .MessageDeliveryStateDelivering:
            self.retryButton.isHidden = true
            self.timeLabel.text = "Delivering"
        }
    }
    
}
