//
//  SodokuSolver.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import Foundation

class SodokuSolver: ObservableObject {
    
    @Published var initialSodoku: Sodoku
    @Published var isValid: Bool = false
    @Published var isBusy: Bool = false
    @Published var errorMessage: String? = nil
    
    init?(from array: [[Int?]]) {
        guard let sodoku = Sodoku(from: array) else { return nil }
        self.initialSodoku = sodoku
        isValid = isSodokuValid()
    }
    
    init() {
        let array: [[Int?]] = Array(repeating: Array(repeating: nil, count: 9), count: 9)
        self.initialSodoku = Sodoku(from: array)!
    }
    
    
    
}

//MARK: - Initializations stuff
extension SodokuSolver {
    subscript(row: Int, column: Int) -> Node {
        get {
            return initialSodoku[row, column]
        }
        set {
            objectWillChange.send()
            initialSodoku[row, column] = newValue
        }
    }
    
    func newBuzzel() {
        if let sodoku = Sodoku(from: SodokuProvider.exampleHard001) {
            self.initialSodoku = sodoku
            isValid = isSodokuValid()
        }
    }
    
    func isSodokuValid() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if case .empty = initialSodoku[row, col]  {
                
                } else {
                    return true
                }
            }
        }
        return false
    }
}

//MARK: - Solving Stuff
extension SodokuSolver {
    /// check if some int value valid to be placed in  cell at row & col of a givin sodoku
    /// - Parameters:
    ///   - value: int value to placed in cell
    ///   - sodoku: sodoku matrix
    ///   - row: row of the cell
    ///   - col: col of cell
    /// - Returns: return true if no match value in the difined row or col or in smaller rectangle
    @discardableResult private func isValidValueForCell(value: Int, sodoku: DualNodeArray, row: Int, col: Int) -> Bool {
        // check row
        guard isValidValueForCellInRow(value: value, sodoku: sodoku, row: row) else { return false}
        // check col
        guard isValidValueForCellInCol(value: value, sodoku: sodoku, col: col) else { return false}
        // check inner rectangle
        
        return isValidValueForCellInInnerRectangle(value: value, sodoku: sodoku, row: row, col: col)
    }
    
    private func isValidValueForCellInRow(value: Int, sodoku: DualNodeArray, row: Int) -> Bool {
        for col in 0..<9 {
            if sodoku[row, col].hasValue(of: value) {
                return false
            }
            
        }
        return true
    }
    
    private func isValidValueForCellInCol(value: Int, sodoku: DualNodeArray, col: Int) -> Bool {
        for row in 0..<9 {
            if sodoku[row, col].hasValue(of: value) {
                return false
            }
            
        }
        return true
    }
    
    private func isValidValueForCellInInnerRectangle(value: Int, sodoku: DualNodeArray, row: Int, col: Int) -> Bool {
        // get rectangle
        let cornerRow = (row / 3) * 3
        let cornerCol = (col / 3) * 3
        let endCornerRow = cornerRow + 2
        let endCornerCol = cornerCol + 2
//        print("row: \(row), col: \(col), cornerStart(\(cornerRow), \(cornerCol)), cornerEnd: (\(endCornerRow), \(endCornerCol))")
        
        for r in cornerRow...endCornerRow {
            for c in cornerCol...endCornerCol {
                
                if sodoku[r, c].hasValue(of: value) {
                    return false
                }
            }
        }
        return true
    }
    
    private func nextAvailableCell(from sodoku: DualNodeArray) -> (row: Int, col: Int)? {
        for r in 0..<9 {
            for c in 0..<9 {
                if case .empty = sodoku[r, c] {
                    return (r, c)
                }
            }
        }
        
        return nil
    }
    
    // MARK: Recursive Func
    private func tryFindSolution(sodoku: DualNodeArray) -> DualNodeArray? {
        guard let cell = nextAvailableCell(from: sodoku) else { return sodoku }
        
        for value in 1..<10 {
            let temp = isValidValueForCell(value: value, sodoku: sodoku, row: cell.row, col: cell.col)
            if temp {
                var nextSodoku = sodoku
                nextSodoku[cell.row, cell.col] = .variant(value: value)
                if let success = tryFindSolution(sodoku: nextSodoku) {
                    return success
                }
            }
        }
        
        return nil
    }
    
    func solve() {
        let cells = initialSodoku.cells
        isBusy = true
        if let solution = tryFindSolution(sodoku: cells) {
            self.initialSodoku.applySolution(cells: solution)
            isBusy = false
        } else {
            errorMessage = "Can't find solution"
            isBusy = false
        }
//        for value in 1..<10 {
//            let temp = isValidValueForCell(value: value, sodoku: initialSodoku, row: 4, col: 3)
//            print("value: \(value), isValid: \(temp)")
//        }
//        objectWillChange.send()
//        initialSodoku[4,3] = .variant(value: 5)
    }
}

