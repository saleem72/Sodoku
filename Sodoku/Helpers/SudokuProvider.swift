//
//  SodokuProvider.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import Foundation

class SudokuProvider {
    static let exampleHard001: [[Int?]] = [
        [nil, 5, nil, nil, nil, 2, 8, 9, nil],
        [nil, nil, 6, nil, nil, nil, nil, nil, 2],
        [nil, 8, 9, nil, 3, nil, nil, 5, nil],
        [nil, 1, 2, 4, nil, nil, 7, nil, 9],
        [nil, 6, nil, nil, 8, nil, nil, 1, nil],
        [5, nil, 8, nil, nil, nil, 4, 3, nil],
        [nil, 2, nil, 8, nil, nil, 9, 7, nil],
        [nil, nil, nil, nil, nil, nil, 3, nil, nil],
        [nil, nil, 1, 7, nil, nil, nil, 2, nil]
    ]
    
    static let exampleHard001Solution: [[Int]] = [
        [1, 5, 4, 6, 7, 2, 8, 9, 3],
        [7, 3, 6, 5, 9, 8, 1, 4, 2],
        [2, 8, 9, 1, 3, 4, 6, 5, 7],
        [3, 1, 2, 4, 5, 6, 7, 8, 9],
        [4, 6, 7, 3, 8, 9, 2, 1, 5],
        [5, 9, 8, 2, 1, 7, 4, 3, 6],
        [6, 2, 3, 8, 4, 5, 9, 7, 1],
        [8, 7, 5, 9, 2, 1, 3, 6, 4],
        [9, 4, 1, 7, 6, 3, 5, 2, 8]
    ]
    
    static var sudokuExample: Sudoku = {
        var sudoku = Array(repeating: Array(repeating: NodeTemplate(), count: 9), count: 9)
        for row in 0..<9 {
            for col in 0..<9 {
                sudoku[row, col].row = row
                sudoku[row, col].col = col
                if let value = exampleHard001[row][col] {
                    sudoku[row, col].node = .starter(value: value)
                }
            }
        }
        return sudoku
    }()
    
    static func loadBuzzels() -> Result<[ExampleDTO], SudokuProviderError> {
        guard let url = Bundle.main.url(forResource: "exapmles", withExtension: "json") else {
            print("Error: Can't find exapmles.json")
            return .failure(.fileNotFound)
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Error: exapmles.json contain bad things")
            return .failure(.badFile)
        }
        
        do {
            let decoder = JSONDecoder()
            let examples = try decoder.decode([ExampleDTO].self, from: data)
            return .success(examples)
        } catch {
            print("Error: some of exapmles.json data are corropted")
            return .failure(.decodingError)
        }
    }
}

extension SudokuProvider {
    enum SudokuProviderError: Error, LocalizedError {
        case fileNotFound
        case badFile
        case decodingError
        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return NSLocalizedString("Can't find exapmles.json", comment: "")
            case .badFile:
                return NSLocalizedString("exapmles.json contain bad things", comment: "")
            case .decodingError:
                return NSLocalizedString("some of exapmles.json data are corropted", comment: "")
            }
        }
    }
}
