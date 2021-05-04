//
//  FriendsVC.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/4/30.
//

import UIKit

class FriendsVC: UIViewController {

    @IBOutlet weak var minYTopView: NSLayoutConstraint!
    @IBOutlet weak var viewTop: UIStackView!
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var btnKokoId: UIButton!
    @IBOutlet weak var viewDot: UIView!
    @IBOutlet weak var invitionView: FriendInvitionView!
    @IBOutlet weak var heightInvitionView: NSLayoutConstraint!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var friendView: FriendsView!
//    @IBOutlet weak var chatView: UIView!
//    @IBOutlet weak var stackView: UIStackView!
//    @IBOutlet weak var scrollView: UIScrollView!
    private var emptyFriendView: NoneFriendView?
    private var viewModel: FriendsVMInterface?
    private var friendList: [Friend] = []
    private var invitionList: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }
}

extension FriendsVC {
    
    private func initView() {
        self.viewModel = FriendsVM()
        self.viewModel?.getUserData(completion: { [weak self] user in
            guard let user = user else { return }
            self?.viewDot.isHidden = true
            self?.btnName.setTitle(user.name, for: .normal)
            self?.btnKokoId.setTitle("KOKO ID：" + user.kokoid, for: .normal)
        })
        
        self.viewModel?.getFriendList(completion: { [weak self] friendList in
            self?.onGetFriendList(friendList)
        })
    }
    
    private func onGetFriendList(_ friendList: [Friend]) {
        self.invitionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        if friendList.isEmpty {
            self.emptyFriendView?.removeFromSuperview()
            if let subView = self.emptyFriendView {
                self.friendView.addFixView(view: subView)
            }else {
                self.emptyFriendView = NoneFriendView()
                self.friendView.addFixView(view: self.emptyFriendView!)
            }
        }else {
            self.friendList = friendList.filter({$0.status != 2})
            self.invitionList = friendList.filter({$0.status == 2})
            self.friendView.configFriendsView(list: self.friendList, delegate: self)
            self.invitionView.configData(list: self.invitionList, delegate: self)
        }
    }
}

extension FriendsVC: InvitionViewDelegate {
    
    func onGet(height: CGFloat, _ view: FriendInvitionView) {
        UIView.animate(withDuration: 0.3) {
            self.invitionView.backgroundColor = self.invitionView.isExpanded ? .white : #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
            self.categoryView.backgroundColor = self.invitionView.isExpanded ? .white : #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
            self.heightInvitionView.constant = height
            self.view.layoutIfNeeded()
        }
    }
}

extension FriendsVC: FriendsViewDelegate {
    func friendsViewShouldReload(in view: FriendsView) {
        self.viewModel?.requestFriendList(completion: { [weak self] friendList in
            self?.onGetFriendList(friendList)
        })
    }
    
    func shouldMove(Top moveTop: Bool, for view: FriendsView) {
        if moveTop && self.minYTopView.constant == 0 {
            self.minYTopView.constant = -self.viewTop.frame.height
        }else if !moveTop && self.minYTopView.constant != 0 {
            self.minYTopView.constant = 0
        }else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}
