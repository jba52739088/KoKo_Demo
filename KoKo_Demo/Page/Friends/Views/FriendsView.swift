//
//  FriendsView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/2.
//

import UIKit

protocol FriendsViewDelegate {
    func friendsViewShouldReload(in view: FriendsView)
    func shouldMove(Top moveTop: Bool, for view: FriendsView)
}

class FriendsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAddFriend: UIButton!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var tableView: UITableView!

    private var delegate: FriendsViewDelegate?
    private var friendList: [Friend] = []
    private var filiterList: [Friend] = []
    private var refreshControl: UIRefreshControl?
    private var isRefreshing = false
    private var isSearching = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func configFriendsView(list: [Friend], delegate: FriendsViewDelegate) {
        self.delegate = delegate
        self.friendList = list
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        self.isRefreshing = false
    }
}

extension FriendsView {
    
    private func initView() {
        Bundle.main.loadNibNamed("FriendsView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.searchBar.delegate = self
        self.tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.onPullForRefresh), for: .allEvents)
        self.tableView.refreshControl = self.refreshControl
    }
    
    @objc private func onPullForRefresh() {
        if !self.isRefreshing {
            self.isRefreshing = true
            self.delegate?.friendsViewShouldReload(in: self)
        }
        
    }
    
}

extension FriendsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !isSearching ? self.friendList.count : self.filiterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FriendCell
            else { return UITableViewCell() }
        let list = !isSearching ? self.friendList : self.filiterList
        cell.configFriendCell(data: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
}

extension FriendsView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearching = (searchText != "")
        self.filiterList = self.friendList.filter({$0.name.contains(searchText)})
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.delegate?.shouldMove(Top: true, for: self)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.delegate?.shouldMove(Top: false, for: self)
    }
}
