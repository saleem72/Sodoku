//
//  HomeScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import SwiftUI
struct HomeScreen: View {
    
    @StateObject private var buzzel: SodokuSolver = SodokuSolver(from: SodokuProvider.exampleHard001) ?? SodokuSolver()
    
    var body: some View {
        NavigationView {
            ZStack {
                content
                if let error = buzzel.errorMessage {
                    Text(error)
                        .font(.system(size: 44, weight: .bold))
                }
            }
            .navigationTitle("Sodoku")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    newBuzzelButton
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension HomeScreen {
    
    private var content: some View {
        VStack(spacing: 32) {
            GridView(buzzel: buzzel)
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

struct GridView: View {
    
    @ObservedObject var buzzel: SodokuSolver
    
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

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .preferredColorScheme(.dark)
    }
}
