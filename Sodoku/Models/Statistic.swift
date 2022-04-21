//
//  Statistic.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import Foundation

struct Statistic: Identifiable, Codable {
    var id: Int
    var name: String
    var lastTime: String = "-- : --"
    var bestTime: String = "-- : --"
    var rate: Int = 0
    var isDone: Bool = false
}
