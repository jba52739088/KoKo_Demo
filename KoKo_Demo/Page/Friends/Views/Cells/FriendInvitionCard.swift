//
//  FriendInvitionCard.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import UIKit

class FriendInvitionCard: UITableViewCell {
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var traillingCard: NSLayoutConstraint!
    @IBOutlet weak var leadingCard: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setShadow()
    }

    func configInvitionCard(data: Friend, scaling: Bool) {
        
        self.lbName.text = data.name
        self.traillingCard.constant = !scaling ? 0 : 10
        self.leadingCard.constant = !scaling ? 0 : 10
    }
    
    func configCardSize(scaling: Bool) {
        
        self.traillingCard.constant = !scaling ? 0 : 10
        self.leadingCard.constant = !scaling ? 0 : 10
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

extension FriendInvitionCard {
    
    private func setShadow() {
        self.viewCard.layer.shadowOpacity = 0.1
        self.viewCard.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        self.viewCard.layer.shadowRadius = 6
        self.viewCard.layer.shadowColor = UIColor.black.cgColor
        self.viewCard.layer.masksToBounds = false
        self.content.layer.masksToBounds = false
//        self.viewCard.clipsToBounds = false
//        let shadowFrame: CGRect = (self.viewCard.layer.bounds)
//        let shadowPath: CGPath = UIBezierPath(rect: shadowFrame).cgPath
//        self.viewCard.layer.shadowPath = shadowPath
    }
    
}
