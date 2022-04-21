//
//  Matrix.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import Foundation

typealias Matrix = [[Int?]]

enum GameLevel: String, Codable, CaseIterable, Identifiable {
    case medium
    case hard
    case expert
    
    var title: String {
        switch self {
        case .medium: return "Medium"
        case .hard: return "Hard"
        case .expert: return "Expert"
        }
    }
    
    var id: String { rawValue }
}

struct ExampleDTO: Codable {
    var id: Int
    var name: String
    var type: GameLevel
    var matrix: Matrix
}

class Example: Identifiable {
    
    
    
    var id: Int
    var name: String
    var type: GameLevel
    var sudoku: Sudoku
    
    init?(example: ExampleDTO) {
        guard let temp = Self.prepare(array: example.matrix) else { return nil }
        self.id = example.id
        self.name = example.name
        self.type = example.type
        self.sudoku = temp
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
    
    static private func prepare(array: [[Int?]]) -> Sudoku? {
        guard Self.hasValidDimintion(array: array) else { return nil}
        var result: Sudoku = Array(repeating: Array(repeating: Node.empty, count: 9), count: 9)
        for row in 0..<9 {
            for col in 0..<9 {
                if let value = array[row][col] {
                    result[row, col] = .starter(value: value)
                }
            }
        }
        return result
    }
    
    static var example: Example = Example(example: ExampleDTO(id: 1, name: "001", type: .hard, matrix: SudokuProvider.exampleHard001))!
}
