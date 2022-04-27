//
//  SudokuPlayer.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import Foundation
import Combine


class SudokuPlayer: ObservableObject {
    
    @Published var initialSodoku: Sudoku
    @Published var activeCell: GridCell? = nil
    @Published var ignoredCell: GridCell? = nil
    @Published var solution: Sudoku
    @Published var errorCount: Int = 0
    @Published var counter: TimeSpan = .init()
    @Published var counterValue: String = ""
    @Published var showWinning: Bool = false
    var dataCenter: DataCenter? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private var lastKey: Int? = nil
    private var isSparkle: Bool = false
    
    private(set) var example: Example
    init(sudoku: Example) {
        self.initialSodoku = sudoku.sudoku
        self.solution = sudoku.solution
        self.example = sudoku
        counter.$value
            .sink { [weak self] interval in
                self?.counterValue = interval.toDescription
            }
            .store(in: &cancellables)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < 9 && column >= 0 && column < 9
    }
    
    subscript(row: Int, column: Int) -> NodeTemplate {
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
        guard let activeCell = activeCell, initialSodoku[activeCell.row, activeCell.col].value == 0 else { return }
        self.activeCell = nil
        
        if solution[activeCell.row, activeCell.col].value != key {
            initialSodoku[activeCell.row, activeCell.col].animatedWithError = true
            initialSodoku[activeCell.row, activeCell.col].ErrorValue = key
            errorCount += 1
        }
        lastKey = key
        initialSodoku[activeCell.row, activeCell.col] = initialSodoku[activeCell.row, activeCell.col].setAnimated(true)
        
        ignoredCell = activeCell
        if solution[activeCell.row, activeCell.col].value == key {
            initialSodoku[activeCell.row, activeCell.col].node = .variant(value: key)
            
        }
        
        // MARK: Check for key if fullfilled
        if initialSodoku.count(for: key) == 9 {
            print("key \(key) was fullfilled")
            dataCenter?.disableKeyboard(key: key)
        }
        
        // MARK: check for completed row
        if initialSodoku.hasRowFullfilled(activeCell.row) {
            for col in 0..<9 {
                isSparkle = true
                initialSodoku[activeCell.row, col].isSparke = true
            }
        }
        
        // MARK: check for completed col
        if initialSodoku.hasColumnFullfilled(activeCell.col) {
            for row in 0..<9 {
                isSparkle = true
                initialSodoku[row, activeCell.col].isSparke = true
            }
        }
        
        // MARK: check for completed rectangle
        if initialSodoku.hasRectangleFullfilled(row: activeCell.row, col: activeCell.col) {
            print("Rectangle: (\(activeCell.row), \(activeCell.col)) was fullfilled")
            let cornerRow = (activeCell.row / 3) * 3
            let cornerCol = (activeCell.col / 3) * 3
            let endCornerRow = cornerRow + 2
            let endCornerCol = cornerCol + 2
            isSparkle = true
            for r in cornerRow...endCornerRow {
                for c in cornerCol...endCornerCol {
                    initialSodoku[r, c].isSparke = true
                }
            }
        }
        
        if isSparkle {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
                self?.isSparkle = false
                
                if let lastKey = self?.lastKey {
                    self?.checkHighLight(for: lastKey)
                    self?.lastKey = nil
                }
                
                self?.checkForEndGame()
                
                
                
            }
        }
    }
    
    func checkHighLight(for key: Int) {
        guard key > 0, !isSparkle else { return }
        
        highLight(for: key)
    }
    
    func selectCell(_ cell: GridCell) {
        normalGrid()
        if case .empty = initialSodoku[cell.row, cell.col].node {
            activeCell = cell
        } else {
            // highlight all cell with the same value
            highLight(for: initialSodoku[cell.row, cell.col].value)
            
        }
    }
    
    func highLight(for val: Int) {
        for row in 0..<9 {
            for col in 0..<9 {
                if initialSodoku[row, col].hasValue(of: val) {
                    initialSodoku[row, col].isHighLighted = true
                }
            }
        }
    }
    
    func disableHighLight() {
        for row in 0..<9 {
            for col in 0..<9 {
                initialSodoku[row, col].isHighLighted = false
            }
        }
    }
    
    func normalGrid() {
        disableHighLight()
        activeCell = nil
        ignoredCell = nil
    }
    
    func checkForEndGame() {
        
        
        
        
        
        // MARK: check for completed game
        if initialSodoku.hasFullFilled() {
//            counter.value.toDescription
            counter.stop()
            showWinning = true
        }
    }
    
}


