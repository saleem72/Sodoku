//
//  AnimatedNodeView.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import SwiftUI

struct AnimatedNodeView: View {
    
    @Binding var node: NodeTemplate
    @ObservedObject var buzzel: SudokuPlayer
    @State private var isAnimated: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBlue))
            
            if node.animatedWithError {
                ZStack {
                    Text("\(node.ErrorValue)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            } else {
                Text(node.text)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .rotation3DEffect(
            Angle(degrees: isAnimated ? 0 : 45),
            axis: (x: 0.0, y: 1.0, z: 1.0)
        )
        .scaleEffect(isAnimated ? 1 : 0.5)
        .offset(x: isAnimated ? 0 : Global.cellWidth * 0.5, y: isAnimated ? 0 : Global.cellWidth)
        .onAppear {
            isAnimated = false
            withAnimation(Animation.easeIn(duration: 0.3)) {
                isAnimated = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                node.isAnimated = false
                node.animatedWithError = false
                node.ErrorValue = 0
                buzzel.normalGrid()
                buzzel.checkHighLight(for: node.value)
            }
        }
        .zIndex(2)
    }
}
