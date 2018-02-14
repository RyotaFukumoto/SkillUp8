//
//  MessageListViewController.swift
//  SkillUp8
//
//  Created by ryota on 2018/02/05.
//  Copyright © 2018年 ryota. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController,UITextViewDelegate {

    let dataSource = MessageListProvider()
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var sendBTN: UIButton!
    @IBOutlet weak var inputVIew: UITextView!
    
    @IBAction func sendBTN(_ sender: UIButton) {
        MessageDao.addMessage(message: inputVIew.text)
        inputVIew.resignFirstResponder()
        setUp()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
       
        inputVIew.delegate = self
        
        setUp()
        tableView.separatorStyle = .none

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        configureObserver()
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.removeObserver()
        
    }
    
    func setUp(){
        inputVIew.text = ""
        sendBTN.isEnabled = false
        reloadMessages()
    }
    
    //セクション毎にセクションラベルと、値のセット
    func reloadMessages() {
        
        let groups = MessageDao.groupByPostDate()
        let messages = groups.map {
            MessageDao.fina(postDate: $0)
        }
        print(messages.first)
        dataSource.set(messageList: messages, groupList: groups)
        tableView.reloadData()
        tableViewScrollToBottom(animated: false)
        
    }
    
    //最新のメッセージに移動
    func tableViewScrollToBottom(animated: Bool) {

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        
            let sections = self.tableView.numberOfSections
            if sections > 0 {
                let rows = self.tableView.numberOfRows(inSection: sections-1)
                let indexPath = IndexPath(row: rows - 1 , section: sections - 1)
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
            
        }
    }
    
    // Notificationを設定
    func configureObserver() {
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Notificationを削除
    func removeObserver() {
        
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    // キーボードが現れた時に、画面全体をずらす。
    @objc func keyboardWillShow(notification: Notification?) {
        
        let rect = (notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration:TimeInterval = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -rect.size.height)
            self.view.transform = transform
        },completion:nil)
    }
    
    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide(notification: Notification?) {
        
        let duration = (notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double)
        UIView.animate(withDuration: duration, animations:{
            self.view.transform = CGAffineTransform.identity
        },
                                   completion:nil)
    }
    //入力フィールドのサイズ変更
    func textViewDidChange(_ textView: UITextView) {
        if inputVIew.text.isEmpty{
            return
        }
        sendBTN.isEnabled = true
        let maxHeight = 100.0  // 入力フィールドの最大サイズ
        if(textView.frame.size.height.native < maxHeight) {
            let size:CGSize = inputVIew.sizeThatFits(inputVIew.frame.size)
            inputVIew.frame.size.height = size.height
        }
    }


}
