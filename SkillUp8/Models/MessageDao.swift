//
//  MessageDao.swift
//  SkillUp8
//
//  Created by ryota on 2018/02/01.
//  Copyright © 2018年 ryota. All rights reserved.
//

import Foundation

class MessageDao {
    static let dao = RealmDaoHelper<MessageDto>()
    
    //メッセージ追加
    static func addMessage(message: String) {
        let obje = MessageDto()
        let newID = dao.newId()
        obje.messageID = newID!
        obje.message = message
        obje.date = Date()
        
        dao.add(object: obje)
        
    }
    
    static func fina(postDate: String) -> [MessageDto] {

        let format = DateFormatter()
        format.locale = Locale(identifier: "ja_JP")
        format.dateStyle = .medium
        format.timeStyle = .medium

        let fromDate = format.date(from: "\(postDate) 00:00:00")!
        let toDate = format.date(from: "\(postDate) 23:59:59")!
        
        
        return dao.findAll()
            .filter("date >= %@ AND date <= %@", fromDate,toDate)
            .map { MessageDto(value: $0) }
    }
    static func groupByPostDate() -> [String] {
        
        let messages = MessageDao.dao.findAll()
        var results = [String]()
        
        for message in messages {
            let postDate = message.date.description.components(separatedBy: " ").first
            
            if (results.filter { $0 == postDate }.count > 0) {
                continue
            }
            results.append(postDate!)
        }
        return results
    }
    
    //メッセージ一取得　降順
    static func findAll() -> [MessageDto]{
        
        return dao.findAll().sorted(byKeyPath: "date", ascending: true).map{
            MessageDto.init(value: $0)
        }
    }
    // メッセージをすべて削除する
    static func deleteAll() {
        dao.deleteAll()
    }
   
}
