//
//  FriendsVC.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/4/30.
//

import UIKit

class FriendsVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var friendView: UIView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let noneFriendView = NoneFriendView.shared!
        let friendView = FriendsView.shared!
        let msgView = ChatView.shared!
        noneFriendView.frame = friendView.frame
        msgView.frame = chatView.frame
//        self.friendView.addSubview(noneFriendView)
        self.friendView.addSubview(friendView)
        self.chatView.addSubview(msgView)
        self.view.layoutIfNeeded()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
