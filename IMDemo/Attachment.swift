//
//  Attachment.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/21.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

class Attachment: NSObject {
    var dict = ["id": "002", "name": "abc"]
    var attachmentStr: String?
    var id: String?
    var name: String?
}

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
