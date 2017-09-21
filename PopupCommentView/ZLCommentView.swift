//
//  ZLCommentView.swift
//  PopupCommentView
//
//  Created by Zerella on 2017/9/21.
//  Copyright © 2017年 Zerella. All rights reserved.
//

import UIKit

protocol ZLCommentViewDelegate {
    func sendMessage(message:String)
}

class ZLCommentView: UIView,UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeHolderLab: UILabel!
    var delagate:ZLCommentViewDelegate?
    
    static func newInstance() -> ZLCommentView? {
        let nibView = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)
        if let view = nibView?.first as? ZLCommentView {
            return view
        }
        return nil
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 隐藏 placeHolderLab
        if self.textView.text.characters.count != 0 {
            self.placeHolderLab.isHidden = true
        } else {
            self.placeHolderLab.isHidden = false
        }
        if textView.text.characters.count > 40 {
            let selectRange = textView.markedTextRange
            // 获取高亮部分
            if let selectRange = selectRange {
                let position =  textView.position(from: (selectRange.start), offset: 0)
                if (position != nil) {
                    return
                }
            }
            let content = textView.text
            let textNum = content?.characters.count
            
            // 截取
            if textNum! > 40 {
                let index = content?.index((content?.startIndex)!, offsetBy: 40)
                let str = content?.substring(to: index!)
                textView.text = str
            }
        }
    }
    
    // 发送
    @IBAction func sendBtnAction(_ sender: Any) {
        self.delagate?.sendMessage(message: self.textView.text)
        self.textView.text = nil
        self.placeHolderLab.isHidden = false
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
