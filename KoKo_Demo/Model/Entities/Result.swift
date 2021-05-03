//
//  Result.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/3.
//

import UIKit

public struct Result<T: Codable>: Codable{
    let response: T?
}
