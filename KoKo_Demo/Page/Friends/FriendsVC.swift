//
//  FriendsVC.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/4/30.
//

import UIKit

class FriendsVC: UIViewController {

    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var btnKokoId: UIButton!
    @IBOutlet weak var viewDot: UIView!
    @IBOutlet weak var invitionView: FriendInvitionView!
    @IBOutlet weak var heightInvitionView: NSLayoutConstraint!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var friendView: FriendsView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var viewModel: FriendsVMInterface?
    private var friendList: [Friend] = []
    private var invitionList: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let noneFriendView = NoneFriendView.shared!
//        let friendView = FriendsView.shared!
        let msgView = ChatView.shared!
//        noneFriendView.frame = friendView.frame
        msgView.frame = chatView.frame
//        self.friendView.addSubview(noneFriendView)
//        self.friendView.addSubview(friendView)
        self.chatView.addSubview(msgView)
        self.view.layoutIfNeeded()
    }
}

extension FriendsVC {
    
    func initView() {
        self.viewModel = FriendsVM()
        self.viewModel?.getUserData(completion: { [weak self] user in
            guard let user = user else { return }
            self?.viewDot.isHidden = true
            self?.btnName.setTitle(user.name, for: .normal)
            self?.btnKokoId.setTitle("KOKO ID：" + user.kokoid, for: .normal)
        })
        
        self.viewModel?.getFriendList(completion: { [weak self] friendList in
            guard let self = self else { return }
            if friendList.isEmpty {
                let view = NoneFriendView(frame: self.friendView.frame)
                self.friendView.addSubview(view)
            }else {
                self.friendList = friendList.filter({$0.status != 2})
                self.invitionList = friendList.filter({$0.status == 2})
                self.friendView.configFriendsView(list: self.friendList)
                self.invitionView.configData(list: self.invitionList, delegate: self)
//                self.invitionView.backgroundColor = self.invitionList.isEmpty ? #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1) : .white
                self.invitionView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
            }
        })
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
