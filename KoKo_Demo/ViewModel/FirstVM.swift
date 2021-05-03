//
//  FirstVM.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import Foundation


enum DemoType: Int {
    case EmptyFriend = 0
    case OnlyFriend = 1
    case FriendAndInvition = 2
}

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
            _list = self.combineArray(list_1: _list_1, list_2: _list_2)
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
    
    private func combineArray(list_1: [Friend], list_2: [Friend]) -> [Friend] {
        let newArray = list_1.reduce(into: list_2) { array, object in
            if let index = array.firstIndex(where: { $0.name == object.name }) {
                if let date1 = self.stringToDate(array[index].updateDate),
                   let date2 = self.stringToDate(object.updateDate),
                   date1 < date2 {
                    array[index] = object
                }
            } else {
                array.append(object)
            }
        }
        return newArray
    }
    
    private func stringToDate(_ String: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateFormatter_2 = DateFormatter()
        dateFormatter_2.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: String) ?? dateFormatter_2.date(from: String)
    }
    
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
