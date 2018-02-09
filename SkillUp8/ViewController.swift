//
//  ViewController.swift
//  SkillUp8
//
//  Created by ryota on 2018/02/01.
//  Copyright © 2018年 ryota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MessageDao.addMessage(text: "test")
        MessageDao.addMessage(text: "test2")
        
        print(MessageDao.findAll())
        print(MessageDao.groupByPostDate())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

