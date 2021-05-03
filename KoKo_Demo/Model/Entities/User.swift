//
//  User.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import Foundation

struct User: Codable {
    let name: String
    let kokoid: String

    
    enum Keys: String, CodingKey {
        case name
        case kokoid
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        kokoid = try container.decodeIfPresent(String.self, forKey: .kokoid) ?? ""
    }
}
