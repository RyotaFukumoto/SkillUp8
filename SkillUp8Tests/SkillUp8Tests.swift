//
//  SkillUp8Tests.swift
//  SkillUp8Tests
//
//  Created by ryota on 2018/02/01.
//  Copyright © 2018年 ryota. All rights reserved.
//

import XCTest
@testable import SkillUp8

class SkillUp8Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        MessageDao.deleteAll()
    }
    
    override func tearDown() {
        MessageDao.deleteAll()
        super.tearDown()
    }
    func testMessageDto(){
        let messageID = 1
        let message = "Test"
        let date = Date()
        
        let msg = MessageDto()
        msg.messageID = messageID
        msg.message = message
        msg.date = date
        
        XCTAssertEqual(msg.messageID, 1)
        XCTAssertEqual(msg.message, "Test")
        XCTAssertEqual(msg.date, date)
    }
    
    func testPrimaryKey() {
        let primaryKey = MessageDto.primaryKey()
        
        XCTAssertEqual(primaryKey, "messageID")
    }
    
    func testMessageAdd(){
        MessageDao.addMessage(message: "Test")
        let messages = MessageDao.findAll()
        XCTAssertEqual("Test", messages.first?.message)
    }
    
    func testMessagesAdd(){
        MessageDao.addMessage(message: "Test1")
        MessageDao.addMessage(message: "Test2")
        
        let messages =  MessageDao.findAll()
        
        XCTAssertEqual(messages.first?.message, "Test1")
        XCTAssertEqual(messages.last?.message, "Test2")
    }
    
    func testFuin(){
        MessageDao.addMessage(message: "Test")
        let message  = MessageDao.fina(postDate: "2018-02-15")
        
        XCTAssertEqual(message.first?.message, "Test")
    }
    func testFuinAll(){
        MessageDao.addMessage(message: "Test1")
        MessageDao.addMessage(message: "Test2")
        let message = MessageDao.findAll()
        XCTAssertEqual(message.count, 2)
        XCTAssertEqual(message.first?.message, "Test1")
        XCTAssertEqual(message.last?.message, "Test2")
        
    }
    
    func testGroupByPostDate(){
        MessageDao.addMessage(message: "Test1")
        MessageDao.addMessage(message: "Test2")
        let group =  MessageDao.groupByPostDate()
        XCTAssertEqual(group.first, "2018-02-15")
    }
    func testDeleteAll(){
        MessageDao.addMessage(message: "Test1")
        MessageDao.addMessage(message: "Test2")
        
        let message1 = MessageDao.findAll()
        XCTAssertEqual(message1.first?.message, "Test1")
        XCTAssertEqual(message1.last?.message, "Test2")
        MessageDao.deleteAll()
        let message2 = MessageDao.findAll()
        XCTAssertEqual(message2.first?.message, nil)
        XCTAssertEqual(message2.last?.message, nil)
    }
}
