//
//  FriendCell.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnTransfer: UIButton!
    @IBOutlet weak var btnInvition: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configFriendCell(data: Friend) {
        self.lbName.text = data.name
        self.imgStar.isHidden = data.isTop == "0"
        self.btnInvition.isHidden = data.status != 0
        self.btnMore.isHidden = data.status == 0
    }
    
}
