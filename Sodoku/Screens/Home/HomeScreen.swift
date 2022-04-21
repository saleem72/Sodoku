//
//  HomeScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var errorMessage: String? = nil
    @Published var gotoLevels: Bool = false
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
            .background(navLinks)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension HomeScreen {
    private var buttons: some View {
        VStack(spacing: 32) {
            Button(action: {
                dataCenter.mode = .solving
                viewModel.gotoLevels = true
            }, label: {
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
            
            Button(action: {
                dataCenter.mode = .playing
                viewModel.gotoLevels = true
            }, label: {
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
    
    private var navLinks: some View {
        VStack {
            NavigationLink(
                "",
                destination: ChooseLevelScreen(),
                isActive: $viewModel.gotoLevels
            )
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









