//
//  FriendsView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/2.
//

import UIKit

class FriendsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAddFriend: UIButton!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var tableView: UITableView!

    private var friendList: [Friend] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func configFriendsView(list: [Friend]) {
        self.friendList = list
        self.tableView.reloadData()
    }
}

extension FriendsView {
    
    private func initView() {
        Bundle.main.loadNibNamed("FriendsView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
    }
    
}

extension FriendsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FriendCell
            else { return UITableViewCell() }
        cell.configFriendCell(data: self.friendList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
}
