//
//  ViewController.swift
//  PopupCommentView
//
//  Created by Zerella on 2017/9/21.
//  Copyright © 2017年 Zerella. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ZLCommentViewDelegate {
    @IBOutlet weak var messageLab: UILabel!
    @IBOutlet weak var commentBtnAction: UIButton!
    var maskView = UIView()  // 灰色背景视图
    lazy var commentView: ZLCommentView = {
        guard let commentView = ZLCommentView.newInstance() else {
            return ZLCommentView()
        }
        return commentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 灰色背景视图
        maskView.frame = self.view.bounds
        maskView.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
        maskView.isHidden = true
        self.view.addSubview(maskView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideView))
        maskView.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // 点击评论
    @IBAction func commentBtnAction(_ sender: Any) {
        self.commentView.frame = CGRect(x:0,y:self.view.frame.size.height,width:self.view.frame.size.width,height:0);
        self.commentView.delagate = self
        self.view.addSubview(self.commentView)
        self.commentView.textView.becomeFirstResponder()
    }

    // 键盘出现
    func keyBoardWillShow(_ notification: Notification){
        let kbInfo = notification.userInfo
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = kbRect.size.height
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
            self.maskView.isHidden = false
            self.commentView.frame = CGRect(x: 0, y:self.view.frame.size.height - height - 55, width:self.view.frame.size.width, height: 55)
        }
    }
    // 键盘隐藏
    func keyBoardWillHide(_ notification: Notification){
        let kbInfo = notification.userInfo
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration) {
            self.hideView()
        }
    }
    
    // 隐藏背景灰色视图
    func hideView() {
        UIView.animate(withDuration: 0.3) {
            self.commentView.frame = CGRect(x:0,y:self.view.frame.size.height,width:self.view.frame.size.width,height:0);
            self.commentView.removeFromSuperview()
            self.maskView.isHidden = true
        }
    }
    
    func sendMessage(message: String) {
        self.messageLab.text = message
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

