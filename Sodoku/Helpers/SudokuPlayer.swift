//
//  SudokuPlayer.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import Foundation

struct GridCell: Equatable {
    var row: Int
    var col: Int
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}

class SudokuPlayer: ObservableObject {
    
    @Published var initialSodoku: Sudoku
    @Published var activeCell: GridCell? = nil
    @Published var animatedCell: GridCell? = nil
    @Published var ignoredCell: GridCell? = nil
    @Published var highLightedValue: Int? = nil
    @Published var solution: Sudoku
    @Published var animatedCellError: Bool = false
    @Published var animatedCellErrorValue: Int = 0
    
    init(sudoku: Example) {
        self.initialSodoku = sudoku.sudoku
        self.solution = sudoku.solution
    }
    
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
    
    func keyWasTapped(_ key: Int) {
        guard let activeCell = activeCell else { return }
        self.activeCell = nil
        
        if solution[activeCell.row, activeCell.col].value != key {
            animatedCellError = true
            animatedCellErrorValue = key
        } else {
            animatedCellError = false
            animatedCellErrorValue = 0
        }
        
        ignoredCell = activeCell
        if !animatedCellError {
            initialSodoku[activeCell.row, activeCell.col] = .variant(value: key)
        }
        animatedCell = activeCell
//        normalGrid()
    }
    
    
    
    func selectCell(_ cell: GridCell) {
        normalGrid()
        if case .empty = initialSodoku[cell.row, cell.col] {
            activeCell = cell
        } else {
            // highlight all cell with the same value
            highLightedValue = initialSodoku[cell.row, cell.col].value
            
        }
    }
    
    func normalGrid() {
        activeCell = nil
        highLightedValue = nil
        animatedCell = nil
        ignoredCell = nil
    }
    
}


