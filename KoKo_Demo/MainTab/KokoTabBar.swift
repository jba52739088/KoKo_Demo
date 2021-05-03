//
//  KokoTabBar.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/4/30.
//

import UIKit

class KokoTabBar: UITabBar {
    
    let height: CGFloat = 54
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow
            else { return super.sizeThatFits(size) }
        
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = height + window.safeAreaInsets.bottom
        return sizeThatFits
    }
}
