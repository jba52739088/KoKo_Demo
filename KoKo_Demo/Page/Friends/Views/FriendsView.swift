//
//  FriendsView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/2.
//

import UIKit

class FriendsView: UIView {

    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAddFriend: UIButton!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    private static var _shared: FriendsView?
    static var shared: FriendsView!{
        if _shared == nil{
            _shared = UINib(nibName: "FriendsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? FriendsView
        }
        return _shared
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
