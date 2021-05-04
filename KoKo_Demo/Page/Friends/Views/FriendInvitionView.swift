//
//  FriendInvitionView.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import UIKit

protocol InvitionViewDelegate {
    func onGet(height: CGFloat, _ view: FriendInvitionView)
}

class FriendInvitionView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var invitionList: [Friend] = []
    private(set) var isExpanded = false
    private var delegate: InvitionViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func configData(list: [Friend], delegate: InvitionViewDelegate) {
        self.invitionList = list
        self.delegate = delegate
        self.configViewHeight()
        self.tableView.reloadData()
    }
}

extension FriendInvitionView {
    
    private func initView() {
        Bundle.main.loadNibNamed("FriendInvitionView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.tableView.register(UINib(nibName: "FriendInvitionCard", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func configViewHeight() {
        var height: CGFloat = 0
        if invitionList.count == 0 {
            // 無資料
            height = 14
        }else if invitionList.count == 1 {
            // 只有一筆資料無論開合高度一樣
            height = 120
        }else if !self.isExpanded {
            // 無展開時高度一樣
            height = 130
        }else {
            height = 190
        }
        self.delegate?.onGet(height: height, self)
        
    }
}

extension FriendInvitionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.invitionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FriendInvitionCard
            else { return UITableViewCell() }
        let scaling = !self.isExpanded && indexPath.section != 0
        cell.configInvitionCard(data: self.invitionList[indexPath.section], scaling: scaling)
        cell.content.layer.zPosition = -CGFloat( self.invitionList.count - indexPath.section)
        cell.selectionStyle = .none
        cell.superview?.clipsToBounds = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }else {
            if !self.isExpanded {
                return indexPath.section == 1 ? 10 : 0
            }else {
                return 80
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return !self.isExpanded ? 0 : 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isExpanded = !self.isExpanded
        self.configViewHeight()
        tableView.visibleCells.forEach { (cell) in
            guard let card = cell as? FriendInvitionCard else { return }
            let _indexPath = tableView.indexPath(for: card)
            card.configCardSize(scaling: !self.isExpanded && _indexPath?.section != 0)
        }
        UIView.animate(withDuration: 0.3) {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
}
