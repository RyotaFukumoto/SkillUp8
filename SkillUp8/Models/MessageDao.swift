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
    
    ///    メッセージ追加
    static func addMessage(message: String) {
        let obje = MessageDto()
        guard let newID = dao.newId() else {
            return
        }
        obje.messageID = newID
        obje.message = message
        obje.date = Date()
        
        dao.add(object: obje)
        
    }
    
    static func fina(postDate: String) -> [MessageDto] {
        
        let fromDate = "\(postDate) 00:00:00".toDateStyleMedium(dateFormat: "yyyy-MM-dd HH:mm:ss")
        let toDate = "\(postDate) 23:59:59".toDateStyleMedium(dateFormat: "yyyy-MM-dd HH:mm:ss")
        
        return dao.findAll()
            .filter("date >= %@ AND date <= %@", fromDate,toDate)
            .map { MessageDto(value: $0) }
    }
    static func groupByPostDate() -> [String] {
        
        let messages = MessageDao.dao.findAll()
        var results = [String]()
        
        for message in messages {
            guard let postDate = message.date
                .description.components(separatedBy: " ").first else {
                    continue
            }
            
            if (results.filter { $0 == postDate }.count > 0) {
                continue
            }
            results.append(postDate)
        }
        return results
    }
    
    ///メッセージ一取得　降順
    static func findAll() -> [MessageDto]{
        
        return dao.findAll().sorted(byKeyPath: "date", ascending: true).map{
            MessageDto.init(value: $0)
        }
    }
   
}
