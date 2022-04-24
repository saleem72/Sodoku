//
//  Node.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import SwiftUI

enum Node: Identifiable {
    case empty
    case starter(value: Int)
    case variant(value: Int)
    
    var id: String { UUID().uuidString }
    
    var color: Color {
        switch self {
        case .empty: return Color.primary
        case .starter(value: _): return Color(.systemTeal)
        case .variant(value: _): return Color.primary
        }
    }
    
    var text: String {
        switch self {
        case .empty: return ""
        case .starter(value: let value): return "\(value)"
        case .variant(value: let value): return "\(value)"
        }
    }
    
    func hasValue(of val: Int) -> Bool {
        switch self {
        case .empty: return false
        case .starter(value: let value): return value == val
        case .variant(value: let value): return value == val
        }
    }
    
    var value: Int {
        switch self {
        case .empty: return 0
        case .starter(value: let value): return value
        case .variant(value: let value): return value
        }
    }
}


typealias NodeArray = [Node]
typealias Sudoku = [NodeArray]

extension Array where Element == NodeArray {
    subscript(row: Int, col: Int) -> Node {
        get {
            assert(row>=0 && row<9, "Index out of range")
            assert(col>=0 && col<9, "Index out of range")
            return self[row][col]
        }
        set {
            assert(row>=0 && row<9, "Index out of range")
            assert(col>=0 && col<9, "Index out of range")
            self[row][col] = newValue
        }
    }
    
    var description: String {
        var result = [String]()
        for row in 0..<9 {
            var rowArray = [String]()
            for col in 0..<9{
                rowArray.append(String(self[row, col].value))
            }
            let temp = rowArray.joined(separator: ", ")
            result.append("[\(temp)]")
        }
        return result.joined(separator: ",\n")
    }
}
