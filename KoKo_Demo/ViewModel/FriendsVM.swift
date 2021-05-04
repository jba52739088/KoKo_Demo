//
//  FriendsVM.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import Foundation

protocol FriendsVMInterface {
    /// 使用者資料
    func getUserData(completion: (@escaping (User?) -> ()))
    /// 好友列表
    func getFriendList(completion: (@escaping ([Friend]) -> ()))
    /// 請求好友列表
    func requestFriendList(completion: (@escaping ([Friend]) -> ()))
    
}

class FriendsVM{
    private var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared ) {
        self.apiManager = apiManager
    }
    
    deinit {
        print("🥵🥵🥵🥵🥵FriendsVM deinit")
    }

}
extension FriendsVM: FriendsVMInterface{

    func getUserData(completion: @escaping ((User?) -> ())) {
        completion(self.apiManager.user)
    }
    
    func getFriendList(completion: @escaping (([Friend]) -> ())) {
        completion(self.apiManager.friendList)
    }
    
    func requestFriendList(completion: @escaping (([Friend]) -> ())) {
        switch self.apiManager.demoType {
        case .EmptyFriend:
            self.requestEmptyFriend { list in
                completion(list)
            }
        case .OnlyFriend:
            self.requestOnlyFriend { list in
                completion(list)
            }
        case .FriendAndInvition:
            self.requestFriendAndInvition { list in
                completion(list)
            }
        }
    }
    
}

extension FriendsVM {
    private func requestEmptyFriend(completion: @escaping (([Friend]) -> ())) {
        self.getFriendList_4 { list in
            print("Finished request getFriendList_4")
            self.apiManager.setFiendList(list: list)
            completion(list)
        }
    }
    
    private func requestOnlyFriend(completion: @escaping (([Friend]) -> ())) {
        let apiGroup = DispatchGroup()
        var _list: [Friend] = []
        var _list_1: [Friend] = []
        var _list_2: [Friend] = []
        apiGroup.enter()
        self.getFriendList_1 { list in
            print("Finished request getFriendList_1")
            _list_1 = list
            apiGroup.leave()
        }
        apiGroup.enter()
        self.getFriendList_2 { list in
            print("Finished request getFriendList_2")
            _list_2 = list
            apiGroup.leave()
        }
        apiGroup.notify(queue: .main) {
            print("didFinish request")
            _list = Global.combineArray(list_1: _list_1, list_2: _list_2)
            self.apiManager.setFiendList(list: _list)
            completion(_list)
        }
    }
    
    private func requestFriendAndInvition(completion: @escaping (([Friend]) -> ())) {
        self.getFriendList_3 { list in
            print("Finished request getFriendList_3")
            self.apiManager.setFiendList(list: list)
            completion(list)
        }
    }
    
    private func getFriendList_1(completion: @escaping (([Friend]) -> ())) {
        APIManager.shared.getFriendList_1 { (datas) in
            completion(datas)
        }
    }
    
    private func getFriendList_2(completion: @escaping (([Friend]) -> ())) {
        APIManager.shared.getFriendList_2 { (datas) in
            completion(datas)
        }
    }
    
    private func getFriendList_3(completion: @escaping (([Friend]) -> ())) {
        APIManager.shared.getFriendList_3 { (datas) in
            completion(datas)
        }
    }
    
    private func getFriendList_4(completion: @escaping (([Friend]) -> ())) {
        APIManager.shared.getFriendList_4 { (datas) in
            completion(datas)
        }
    }
    
}
