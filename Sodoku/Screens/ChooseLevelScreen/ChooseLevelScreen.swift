//
//  ChooseLevelScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct ChooseLevelScreen: View {
    @State private var level: GameLevel = .medium
    @State private var gotoList: Bool = false
    var body: some View {
        VStack(spacing: 32) {
            ForEach(GameLevel.allCases) { level in
                Button(action: {
                    self.level = level
                    gotoList = true
                }, label: {
                    Text(level.title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .frame(width: 220)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                        )
                })
            }
        }
        .navigationTitle("Game Level")
        .navigationBarTitleDisplayMode(.inline)
        .background(navLinks)
    }
    
    private var navLinks: some View {
        VStack {
            NavigationLink(
                "",
                destination: ExamplesListScreen(level: level),
                isActive: $gotoList
            )
        }
    }
}

struct ChooseLevelScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChooseLevelScreen()
        }
        .environmentObject(DataCenter())
    }
}
