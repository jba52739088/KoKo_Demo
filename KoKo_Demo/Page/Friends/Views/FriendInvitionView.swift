//
//  FriendInvitionView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import UIKit

class FriendInvitionView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var count: Int = 0
    private var isExpanded = false
    private(set) var viewHeight: CGFloat = 14
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initXib()
    }
    
    func configData(count: Int, isExpanded: Bool = false) {
        self.count = 0
        self.isExpanded = isExpanded
        self.configViewHeight()
    }
}

extension FriendInvitionView {
    
    private func initXib() {
        Bundle.main.loadNibNamed("FriendInvitionView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.tableView.register(UINib(nibName: "FriendInvitionCard", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func configViewHeight() {
        if count == 0 {
            // 無資料
            self.viewHeight = 14
            return
        }else if count == 1 {
            // 只有一筆資料無論開合高度一樣
            self.viewHeight = 120
            return
        }else if !self.isExpanded {
            // 無展開時高度一樣
            self.viewHeight = 107
            return
        }
        
//        if self.isExpanded && self.count > 1 {
//            self.viewHeight = 50 + (self.count * 70) + ((self.count - 1) * 25)
//            return
//        }
//        else if count > 3 {
//
//        }else {
//            self.viewHeight = 50 + (self.count * 70) + ((self.count - 1) * 25)
//        }
    }
}

extension FriendInvitionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FriendInvitionCard
            else { return UITableViewCell() }
        
        return cell
    }
    
}
