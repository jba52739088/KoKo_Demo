//
//  NoneFriendView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/2.
//

import UIKit

class NoneFriendView: UIView {
    
    @IBOutlet var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initXib()
    }
}

extension NoneFriendView {
    
    private func initXib() {
        Bundle.main.loadNibNamed("NoneFriendView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
