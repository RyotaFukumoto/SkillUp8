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
        MessageDao.addMessage(text: inputVIew.text)
        reloadMessages()
        inputVIew.text = ""
        sendBTN.isEnabled = false
        inputVIew.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource

        inputVIew.delegate = self
        sendBTN.isEnabled = false
        reloadMessages()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func reloadMessages() {
        
        let groups = MessageDao.groupByPostDate()
        
        let messages = groups.map {
            MessageDao.fina(postDate: $0)
        }
        dataSource.set(messageList: messages, groupList: groups)
       tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.configureObserver()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.removeObserver() // Notificationを画面が消えるときに削除
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
        
        let rect = (notification?.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform
            
        })
    }
    
    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide(notification: Notification?) {
        
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            
            self.view.transform = CGAffineTransform.identity
        })
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
