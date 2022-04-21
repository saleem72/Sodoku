//
//  SodokuSolver.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import Foundation

class SudokuSolver: ObservableObject {
    
    @Published var initialSodoku: Sudoku
    @Published var isValid: Bool = false
    @Published var isBusy: Bool = false
    @Published var errorMessage: String? = nil
    
    init?(from array: [[Int?]]) {
        guard let cells = Self.prepare(array: array) else { return nil}
        self.initialSodoku = cells
        isValid = isSodokuValid()
    }
    
    init(sudoku: Sudoku) {
        self.initialSodoku = sudoku
        isValid = isSodokuValid()
    }
    
    
}

//MARK: - Initializations stuff
extension SudokuSolver {
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < 9 && column >= 0 && column < 9
    }
    
    subscript(row: Int, column: Int) -> Node {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return initialSodoku[row, column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            objectWillChange.send()
            initialSodoku[row, column] = newValue
        }
    }
    
    func newBuzzel() {
        
        guard let cells = Self.prepare(array: SudokuProvider.exampleHard001) else { return }
        self.initialSodoku = cells
        
        isValid = isSodokuValid()
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
}

//MARK: - Solving Stuff
extension SudokuSolver {
    /// check if some int value valid to be placed in  cell at row & col of a givin sodoku
    /// - Parameters:
    ///   - value: int value to placed in cell
    ///   - sodoku: sodoku matrix
    ///   - row: row of the cell
    ///   - col: col of cell
    /// - Returns: return true if no match value in the difined row or col or in smaller rectangle
    @discardableResult private func isValidValueForCell(value: Int, sodoku: Sudoku, row: Int, col: Int) -> Bool {
        // check row
        guard isValidValueForCellInRow(value: value, sodoku: sodoku, row: row) else { return false}
        // check col
        guard isValidValueForCellInCol(value: value, sodoku: sodoku, col: col) else { return false}
        // check inner rectangle
        
        return isValidValueForCellInInnerRectangle(value: value, sodoku: sodoku, row: row, col: col)
    }
    
    private func isValidValueForCellInRow(value: Int, sodoku: Sudoku, row: Int) -> Bool {
        for col in 0..<9 {
            if sodoku[row, col].hasValue(of: value) {
                return false
            }
            
        }
        return true
    }
    
    private func isValidValueForCellInCol(value: Int, sodoku: Sudoku, col: Int) -> Bool {
        for row in 0..<9 {
            if sodoku[row, col].hasValue(of: value) {
                return false
            }
            
        }
        return true
    }
    
    private func isValidValueForCellInInnerRectangle(value: Int, sodoku: Sudoku, row: Int, col: Int) -> Bool {
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
    
    private func nextAvailableCell(from sodoku: Sudoku) -> (row: Int, col: Int)? {
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
    private func tryFindSolution(sodoku: Sudoku) -> Sudoku? {
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
//        let cells = initialSodoku.cells
        isBusy = true
        if let solution = tryFindSolution(sodoku: initialSodoku) {
            self.initialSodoku = solution
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

