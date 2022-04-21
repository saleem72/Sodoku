//
//  HomeScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var errorMessage: String? = nil
    
    init() {
        
    }
}

struct HomeScreen: View {
    
    @StateObject private var viewModel: HomeViewModel = .init()
    @EnvironmentObject private var dataCenter: DataCenter
    
    var body: some View {
        NavigationView {
            ZStack {
                buttons
                errorMessage()
            }
            .navigationTitle("Sudoku")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension HomeScreen {
    private var buttons: some View {
        VStack(spacing: 32) {
            Button(action: {}, label: {
                Text("Solve")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 8)
                    .frame(width: 220)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                    )
            })
            
            Button(action: {}, label: {
                Text("Play")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 8)
                    .frame(width: 220)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGreen))
                    )
            })
        }
    }
    
    @ViewBuilder
    private func errorMessage() -> some View {
        if let error = dataCenter.errorMessage {
            ErrorView(message: error) {
                dataCenter.errorMessage = nil
            }
        }
    }
    
}



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .preferredColorScheme(.dark)
            .environmentObject(DataCenter())
    }
}









