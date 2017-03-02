//
//  ChatMyVoiceCell.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class ChatOtherVoiceCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    var audioPath: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configWith(message: IMMessage){
        self.nickNameLabel.text = message.from
        self.audioPath = message.audioObject.path
        self.timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
    }
    
}
