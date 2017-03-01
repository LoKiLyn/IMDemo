//
//  Attachment.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/21.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class Attachment: IMBaseObject {
    
    override init() {
        super.init()
        super.delegate = self
    }
    
    var dict = ["id": "002", "name": "abc"]
    var attachmentStr: String?
    var id: String?
    var name: String?
}


extension Attachment: IMBaseObjectCoding {
    
    func IMBaseObjectEncodeCoding() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            self.attachmentStr = String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
        return attachmentStr!
    }
    
    func IMBaseObjectDecodeCoding(_ content: String?) -> NIMCustomAttachment? {
        var dict: Dictionary<String, String>?
        let data: Data = (content?.data(using: String.Encoding.utf8))!
        do {
            dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary
        } catch {
            print(error)
        }
        self.name = dict?["name"]
        self.id = dict?["id"]
        return self
    }
}



/*
extension Attachment: NIMCustomAttachment {
    func encode() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            self.attachmentStr = String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
        return attachmentStr!
    }
}

extension Attachment: NIMCustomAttachmentCoding {
    
    func decodeAttachment(_ content: String?) -> NIMCustomAttachment? {
        var dict: Dictionary<String, String>?
        let data: Data = (content?.data(using: String.Encoding.utf8))!
        do {
            dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary
        } catch {
            print(error)
        }
        self.name = dict?["name"]
        self.id = dict?["id"]
        return self
    }
}
*/
