//
//  Sodoku.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import SwiftUI

typealias NodeArray = [Node]
typealias DualNodeArray = [NodeArray]

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
}

class Sodoku: ObservableObject {
    @Published private(set) var cells: DualNodeArray = Array(repeating: Array(repeating: Node.empty, count: 9), count: 9)
    
    init?(from array: [[Int?]]) {
        guard Self.hasValidDimintion(array: array) else { return nil}
        prepare(array: array)
    }
    
    static private func hasValidDimintion(array: [[Int?]]) -> Bool {
        guard array.count == 9 else { return false }
        for row in array {
            if row.count != 9 {
                return false
            }
        }
        
        return true
    }
    
    private func prepare(array: [[Int?]]) {
        for row in 0..<9 {
            for col in 0..<9 {
                if let value = array[row][col] {
                    cells[row][col] = .starter(value: value)
                }
            }
        }
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < 9 && column >= 0 && column < 9
    }
    
    subscript(row: Int, column: Int) -> Node {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return cells[row][column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            objectWillChange.send()
            cells[row][column] = newValue
        }
    }
    
    func applySolution(cells: DualNodeArray) {
        self.cells = cells
    }
}
