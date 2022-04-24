//
//  SolvingBuzzelScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI


struct SolvingBuzzelScreen: View {
    
    @StateObject private var buzzel: SudokuSolver
    
    init(buzzel: Example) {
        self._buzzel = StateObject(wrappedValue: SudokuSolver(sudoku: buzzel.sudoku))
    }
    
    var body: some View {
        ZStack {
            content
            if let error = buzzel.errorMessage {
                Text(error)
                    .font(.system(size: 44, weight: .bold))
            }
        }
        .navigationTitle("Sodoku Solver")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension SolvingBuzzelScreen {
    
    private var content: some View {
        VStack(spacing: 32) {
            GridForSolvingView(buzzel: buzzel)
                .padding(.top, 32)
            
            solveButton()
            
            Spacer(minLength: 0)
        }
    }
    
    @ViewBuilder
    private func solveButton() -> some View {
        if buzzel.isValid {
            Button(action: {
                buzzel.solve()
            }, label: {
                Text("Start Solving")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(width: 280)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGreen)))
                
            })
            .disabled(buzzel.isBusy)
            .opacity(buzzel.isBusy ? 0.6 : 1)
        }
    }
    
    private var newBuzzelButton: some View {
        Button(action: {
            buzzel.newBuzzel()
        }, label: {
            Image(systemName: "doc.fill.badge.plus")
        })
    }
    
}

struct SolvingBuzzelScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SolvingBuzzelScreen(buzzel: Example.example)
        }
    }
}
