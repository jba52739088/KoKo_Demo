//
//  Extension.swift
//  KoKo_Demo
//
//  Created by 黃恩祐 on 2021/5/4.
//

import Foundation

class Global {
    
    static func combineArray(list_1: [Friend], list_2: [Friend]) -> [Friend] {
        let newArray = list_1.reduce(into: list_2) { array, object in
            if let index = array.firstIndex(where: { $0.name == object.name }) {
                if let date1 = stringToDate(array[index].updateDate),
                   let date2 = stringToDate(object.updateDate),
                   date1 < date2 {
                    array[index] = object
                }
            } else {
                array.append(object)
            }
        }
        return newArray
    }

    static func stringToDate(_ String: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateFormatter_2 = DateFormatter()
        dateFormatter_2.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: String) ?? dateFormatter_2.date(from: String)
    }
}


