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
        case .starter(value: _): return Color(.systemBlue)
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

struct NodeTemplate {
    var node: Node = .empty
    var row: Int = 0
    var col: Int = 0
    var isHighLighted: Bool = false
    var isAnimated: Bool = false
    var animatedWithError = false
    var ErrorValue: Int = 0
    var isSparke: Bool = false
    
    var value: Int {
        node.value
    }
    
    func hasValue(of val: Int) -> Bool {
        node.hasValue(of: val)
    }
    
    var color: Color {
        node.color
    }
    
    var text: String {
        node.text
    }
    
    func setAnimated(_ animated: Bool) -> NodeTemplate {
        NodeTemplate(node: self.node, row: row, col: col, isHighLighted: isHighLighted, isAnimated: animated, animatedWithError: animatedWithError, ErrorValue: ErrorValue)
    }
}

typealias NodeArray = [NodeTemplate]
typealias Sudoku = [NodeArray]

extension Array where Element == NodeArray {
    subscript(row: Int, col: Int) -> NodeTemplate {
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
                rowArray.append(String(self[row, col].node.value))
            }
            let temp = rowArray.joined(separator: ", ")
            result.append("[\(temp)]")
        }
        return result.joined(separator: ",\n")
    }
    
    func count(for key: Int) -> Int {
        var count: Int = 0
        for row in 0..<9 {
            for col in 0..<9 {
                if self[row, col].value == key { count += 1 }
            }
        }
        
        return count
    }
    
    func hasRowFullfilled(_ row: Int) -> Bool {
        for col in 0..<9 {
            if self[row, col].value == 0 { return false }
        }
        
        return true
    }
    
    func hasColumnFullfilled(_ col: Int) -> Bool {
        for row in 0..<9 {
            if self[row, col].value == 0 { return false }
        }
        
        return true
    }
    
    func hasRectangleFullfilled(row: Int, col: Int) -> Bool {
        let cornerRow = (row / 3) * 3
        let cornerCol = (col / 3) * 3
        let endCornerRow = cornerRow + 2
        let endCornerCol = cornerCol + 2
        
        for r in cornerRow...endCornerRow {
            for c in cornerCol...endCornerCol {
                
                if self[r, c].value == 0 {
                    return false
                }
            }
        }
        return true
        
    }
    
    func hasFullFilled() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if self[row, col].value == 0 { return false }
            }
        }
        
        return true
    }
    
}
