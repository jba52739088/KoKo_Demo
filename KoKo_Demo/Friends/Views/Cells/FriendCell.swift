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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
