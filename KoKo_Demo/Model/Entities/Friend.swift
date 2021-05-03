//
//  Friend.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import Foundation

struct Friend: Codable {
    let name: String
    let status: Int
    let isTop: String
    let fid: String
    let updateDate: String

    
    enum Keys: String, CodingKey {
        case name
        case status
        case isTop
        case fid
        case updateDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        status = try container.decodeIfPresent(Int.self, forKey: .status) ?? -1
        isTop = try container.decodeIfPresent(String.self, forKey: .isTop) ?? ""
        fid = try container.decodeIfPresent(String.self, forKey: .fid) ?? ""
        updateDate = try container.decodeIfPresent(String.self, forKey: .updateDate) ?? ""
    }
}
