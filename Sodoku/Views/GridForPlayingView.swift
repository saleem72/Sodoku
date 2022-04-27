//
//  GridForPlayingView.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct GridForPlayingView: View {
    
    @ObservedObject var buzzel: SudokuPlayer
    init(buzzel: SudokuPlayer) {
        self.buzzel = buzzel
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<9, id:\.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<9, id:\.self) { col in
                            let cell = GridCell(row: row, col: col)
                            GridCellView(node: $buzzel[row, col], position: cell, buzzel: buzzel)
                                .zIndex(1 - 0.1 * Double(col))
                            
                        }
                    }
                    .zIndex(1 - 0.1 * Double(row))
                }
            }
            .overlay(dividers)
        }
    }
    
    private var dividers: some View {
        ZStack {
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color.pallet.pink)
                    .frame(width: 2)
                Spacer()
                Rectangle()
                    .fill(Color.pallet.pink)
                    .frame(width: 2)
                Spacer()
            }
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.pallet.pink)
                    .frame(height: 2)
                Spacer()
                Rectangle()
                    .fill(Color.pallet.pink)
                    .frame(height: 2)
                Spacer()
            }
            
            Rectangle()
                .stroke(Color.pallet.pink, lineWidth: 2)
        }
    }
}


struct GridForPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        GridForPlayingView(buzzel: SudokuPlayer(sudoku: Example.example))
    }
}

