//
//  ChatView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/2.
//

import UIKit

class ChatView: UIView {

    private static var _shared: ChatView?
    static var shared: ChatView!{
        if _shared == nil{
            _shared = UINib(nibName: "ChatView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? ChatView
        }
        return _shared
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
