//
//  NoneFriendView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/2.
//

import UIKit

class NoneFriendView: UIView {

    private static var _shared: NoneFriendView?
    static var shared: NoneFriendView!{
        if _shared == nil{
            _shared = UINib(nibName: "NoneFriendView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? NoneFriendView
        }
        return _shared
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
