//
//  APIManager.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import UIKit
import Alamofire
//import SwiftyJSON

enum APIInfo: String {
    /// 使用者資料
    case User = "https://dimanyen.github.io/man.json"
    /// 好友列表1
    case FriendList_1 = "https://dimanyen.github.io/friend1.json"
    /// 好友列表2
    case FriendList_2 = "https://dimanyen.github.io/friend2.json"
    /// 好友列表含邀請列表
    case FriendList_3 = "https://dimanyen.github.io/friend3.json"
    /// 無資料邀請/好友列表
    case FriendList_4 = "https://dimanyen.github.io/friend4.json"
}

class APIManager {
    
    static let shared = APIManager()
    private(set) var user: User?
    private(set) var friendList: [Friend] = []
    
    func setUser(user: User?) {
        self.user = user
    }
    
    func setFiendList(list: [Friend]) {
        self.friendList = list
    }
    
    func getUserData(completion: (@escaping (User?) -> ())) {
        self.loadAPI(info: .User) { (result: Result<[User]>?) in
            completion(result?.response?.first)
        }
    }
    
    func getFriendList_1(completion: (@escaping ([Friend]) -> ())) {
        self.loadAPI(info: .FriendList_1) { (result: Result<[Friend]>?) in
            completion(result?.response ?? [])
        }
    }
    
    func getFriendList_2(completion: (@escaping ([Friend]) -> ())) {
        self.loadAPI(info: .FriendList_2) { (result: Result<[Friend]>?) in
            completion(result?.response ?? [])
        }
    }
    
    func getFriendList_3(completion: (@escaping ([Friend]) -> ())) {
        self.loadAPI(info: .FriendList_3) { (result: Result<[Friend]>?) in
            completion(result?.response ?? [])
        }
    }
    
    func getFriendList_4(completion: (@escaping ([Friend]) -> ())) {
        self.loadAPI(info: .FriendList_4) { (result: Result<[Friend]>?) in
            completion(result?.response ?? [])
        }
    }
}

extension APIManager {

    
    private func loadAPI<T>(info: APIInfo, completion: @escaping ((T?) -> ())) where T: Codable{
        AF.request(info.rawValue, method: .get).response { response in
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                if let jsonData = response.data {
                    let result = try? decoder.decode(T.self, from: jsonData)
                    completion(result)
                }
                break
            case .failure(_):
                completion(nil)
                break
            }
        }
    }
    
}
