//
//  MessageListProvider.swift
//  SkillUp8
//
//  Created by ryota on 2018/02/05.
//  Copyright © 2018年 ryota. All rights reserved.
//

import UIKit

class MessageListProvider: NSObject {
    var messageList = [[MessageDto]]()
    var groupList = [String]()
    
    func set(messageList: [[MessageDto]], groupList: [String]) {
        self.messageList = messageList
        self.groupList = groupList
    }
}
extension MessageListProvider:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MessageListTableViewCell
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "HH:mm"
        let date = dateFormater.string(from: messageList[indexPath.section][indexPath.row].date)
        cell?.textV.text = messageList[indexPath.section][indexPath.row].text
        cell?.label.text = date
        
        cell?.textV.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        cell?.textV.sizeToFit()
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupList.count
    }
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return groupList[section]
    }
}
