//
//  DataCenter.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import Foundation

class DataCenter: ObservableObject {
    @Published var examples: [Example] = []
    @Published var statistics: [Statistic] = []
    @Published var errorMessage: String? = nil
    @Published var mode: GameMode = .playing
    
    @Published var keyboard: [KeyBoardKey] = KeyBoardKey.keyboard
    
    init() {
        loadBuzzels()
        loadStatistics()
    }
    
    private func loadBuzzels() {
        let result = SudokuProvider.loadBuzzels()
        switch result {
        case .success(let returnedExamples):
            let examples = returnedExamples.compactMap(Example.init)
            self.examples = examples
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func loadStatistics() {
        
    }
    
    func statistic(for example: Example) -> Statistic {
        if let first = statistics.first(where: {$0.id == example.id}) {
            return first
        } else {
            return Statistic(id: example.id, name: example.name)
        }
    }
    
    func disableKeyboard(key: Int) {
        guard let idx = keyboard.firstIndex(where: {$0.value == key}) else { return }
        keyboard[idx].isActive = false
        
    }
}

extension DataCenter {
    enum GameMode {
        case solving
        case playing
    }
}
