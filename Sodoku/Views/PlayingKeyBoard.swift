//
//  PlayingKeyBoard.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import SwiftUI

struct PlayingKeyBoard: View {
    
    @EnvironmentObject var dataCenter: DataCenter
    var onTab: (Int) -> Void
    
    init(onTab: @escaping (Int) -> Void) {
        self.onTab = onTab
    }
    
    var body: some View {
        HStack(spacing: 8) {
            let itemWidth = Global.keyboardKeyWidth  // (Global.screenWidth - 32 - 72) / 9
            ForEach(dataCenter.keyboard) { key in
                Button(action: {
                    onTab(key.value)
                }, label: {
                    Text("\(key.value)")
                        .frame(width: itemWidth, height: itemWidth)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(.systemBackground))
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke()
                            }
                        )
                })
                .disabled(!key.isActive)
                .opacity(key.isActive ? 1 : 0.6)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
