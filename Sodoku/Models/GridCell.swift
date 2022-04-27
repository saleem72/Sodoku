//
//  GridCell.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import Foundation

struct GridCell: Equatable {
    var row: Int
    var col: Int

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}
