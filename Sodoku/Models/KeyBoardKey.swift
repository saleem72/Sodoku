//
//  KeyBoardKey.swift
//  Sodoku
//
//  Created by Yousef on 4/25/22.
//

import Foundation

struct KeyBoardKey: Identifiable {
    var id: Int { value }
    var value: Int
    var isActive = true
    
    static var keyboard: [KeyBoardKey] = [
        .init(value: 1),
        .init(value: 2),
        .init(value: 3),
        .init(value: 4),
        .init(value: 5),
        .init(value: 6),
        .init(value: 7),
        .init(value: 8),
        .init(value: 9),
    ]
}
