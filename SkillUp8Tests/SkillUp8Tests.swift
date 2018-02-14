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
    
    func testMessageAdd(){
        MessageDao.addMessage(message: "Test")
        let messages = MessageDao.findAll()
        XCTAssertEqual("Test", messages.first?.message)
    }
    func testFuin(){
        MessageDao.addMessage(message: "Test")
        let message  = MessageDao.fina(postDate: "2018-02-14")
        
        XCTAssertEqual(message[0].messageID, 1)
    }
    func testGroupByPostDate(){
        MessageDao.addMessage(message: "Test1")
        MessageDao.addMessage(message: "Test2")

        let group =  MessageDao.groupByPostDate()
        XCTAssertEqual(group.first, "2018-02-14")
    }
}
