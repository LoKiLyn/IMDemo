//
//  IMBaseObject.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/24.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import Foundation


protocol IMBaseObjectCoding {
    func IMBaseObjectEncodeCoding() -> String
    func IMBaseObjectDecodeCoding(_ content: String?) -> NIMCustomAttachment?
}


class IMBaseObject: NSObject {
    
    var delegate: IMBaseObjectCoding?
    
    class func registerCustomDecoder(decoder: NIMCustomAttachmentCoding) {
        NIMCustomObject.registerCustomDecoder(decoder)
    }
    
}


extension IMBaseObject: NIMCustomAttachment {
    func encode() -> String {
        return (self.delegate?.IMBaseObjectEncodeCoding())!
    }
}

extension IMBaseObject: NIMCustomAttachmentCoding {
    
    func decodeAttachment(_ content: String?) -> NIMCustomAttachment? {
        return self.delegate?.IMBaseObjectDecodeCoding(content)
    }
}
