//
//  FirstVM.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import Foundation

protocol FirstVMInterface {
    func requestApi(for type: DemoType, completion: (@escaping (Bool) -> ()))
    
}

class FirstVM{
    private var apiManager: APIManager
    
    init(apiManager: APIManager = APIManager.shared ) {
        self.apiManager = apiManager
    }
    
    deinit {
        print("FriendsVM deinit")
    }

}

extension FirstVM: FirstVMInterface{
    func requestApi(for type: DemoType, completion: @escaping ((Bool) -> ())) {
        self.apiManager.setDemoType(type)
        switch type {
        case .EmptyFriend:
            self.requestEmptyFriend {
                completion(true)
            }
        case .OnlyFriend:
            self.requestOnlyFriend {
                completion(true)
            }
        case .FriendAndInvition:
            self.requestFriendAndInvition {
                completion(true)
            }
        }
    }
    
    private func requestEmptyFriend(completion: @escaping (() -> ())) {
        let apiGroup = DispatchGroup()
        var _user: User? = nil
        var _list: [Friend] = []
        apiGroup.enter()
        self.getUserData { user in
            print("Finished request getUserData")
            _user = user
            apiGroup.leave()
        }
        apiGroup.enter()
        self.getFriendList_4 { list in
            print("Finished request getFriendList_4")
            _list = list
            apiGroup.leave()
        }
        apiGroup.notify(queue: .main) {
            print("didFinish request")
            self.apiManager.setUser(user: _user)
            self.apiManager.setFiendList(list: _list)
            completion()
        }
    }
    
    private func requestOnlyFriend(completion: @escaping (() -> ())) {
        let apiGroup = DispatchGroup()
        var _user: User? = nil
        var _list: [Friend] = []
        var _list_1: [Friend] = []
        var _list_2: [Friend] = []
        apiGroup.enter()
        self.getUserData { user in
            print("Finished request getUserData")
            _user = user
            apiGroup.leave()
        }
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
            self.apiManager.setUser(user: _user)
            self.apiManager.setFiendList(list: _list)
            completion()
        }
    }
    
    private func requestFriendAndInvition(completion: @escaping (() -> ())) {
        let apiGroup = DispatchGroup()
        var _user: User? = nil
        var _list: [Friend] = []
        apiGroup.enter()
        self.getUserData { user in
            print("Finished request getUserData")
            _user = user
            apiGroup.leave()
        }
        apiGroup.enter()
        self.getFriendList_3 { list in
            print("Finished request getFriendList_3")
            _list = list
            apiGroup.leave()
        }
        apiGroup.notify(queue: .main) {
            print("didFinish request")
            self.apiManager.setUser(user: _user)
            self.apiManager.setFiendList(list: _list)
            completion()
        }
    }
    
}

extension FirstVM {
    
    private func getUserData(completion: @escaping ((User?) -> ())) {
        APIManager.shared.getUserData { (data) in
            completion(data)
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
