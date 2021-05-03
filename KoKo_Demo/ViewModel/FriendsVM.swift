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
    
}
