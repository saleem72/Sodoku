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
