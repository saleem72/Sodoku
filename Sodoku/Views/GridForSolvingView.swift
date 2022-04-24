//
//  GridForSolvingView.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct GridForSolvingView: View {
    
    @ObservedObject var buzzel: SudokuSolver
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<9, id:\.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<9, id:\.self) { col in
                            ZStack {
                                Rectangle()
                                    .fill(Color(.systemBackground))
                                Rectangle()
                                    .stroke(Color.pallet.pink.opacity(0.6))
                                let node = buzzel[row, col]
                                Text(node.text)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(node.color)
                            }
                            .frame(width: Global.cellWidth, height: Global.cellWidth)
                        }
                    }
                }
            }
            .overlay(
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
            )
            .overlay(
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
            )
            .overlay(
                Rectangle()
                    .stroke(Color.pallet.pink, lineWidth: 2)
            )
        }
    }
}
