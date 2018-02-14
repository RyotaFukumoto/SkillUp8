//
//  MessageDto.swift
//  SkillUp8
//
//  Created by ryota on 2018/02/01.
//  Copyright © 2018年 ryota. All rights reserved.
//

import Foundation
import RealmSwift
class MessageDto: Object {
    @objc dynamic var messageID = 0
    @objc dynamic var message = ""
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String? {
        return "messageID"
    }
}
