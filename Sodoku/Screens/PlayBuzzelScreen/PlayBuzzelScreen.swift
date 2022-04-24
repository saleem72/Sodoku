//
//  PlayBuzzelScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct PlayBuzzelScreen: View {
    
    @StateObject private var buzzel: SudokuPlayer
    
    init(buzzel: Example) {
        self._buzzel = StateObject(wrappedValue: SudokuPlayer(sudoku: buzzel))
    }
    
    var body: some View {
        ZStack {
            content
//            if let error = buzzel.errorMessage {
//                Text(error)
//                    .font(.system(size: 44, weight: .bold))
//            }
        }
        .navigationTitle("Sodoku Solver")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension PlayBuzzelScreen {
    private var content: some View {
        VStack(spacing: 32) {
            GridForPlayingView(buzzel: buzzel)
                .padding(.top, 32)
                .zIndex(1.0)
            
            PlayingKeyBoard { key in
                buzzel.keyWasTapped(key)
                    
            }
            
            Spacer(minLength: 0)
        }
        .onAppear {
            print(buzzel.solution.description)
        }
    }
}

struct PlayBuzzelScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayBuzzelScreen(buzzel: Example.example)
        }
    }
}


struct PlayingKeyBoard: View {
    
    var onTab: (Int) -> Void
    
    init(onTab: @escaping (Int) -> Void) {
        self.onTab = onTab
    }
    
    var body: some View {
        HStack(spacing: 8) {
            let itemWidth = (Global.screenWidth - 32 - 72) / 9
            ForEach(1...9, id:\.self) { idx in
                Button(action: {
                    onTab(idx)
                }, label: {
                    Text("\(idx)")
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
            }
        }
        .frame(maxWidth: .infinity)
    }
}


struct GridCellView: View {
    
    var node: Node
    var position: GridCell
    @ObservedObject var buzzel: SudokuPlayer
    
    @State private var isAnimated: Bool = false
    @State private var likes: Double = 100
    
    init(node: Node, position: GridCell, buzzel: SudokuPlayer) {
        self.node = node
        self.position = position
        self.buzzel = buzzel
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemBackground))
            Rectangle()
                .stroke(
                    Color.pallet.pink.opacity(0.6),
                    lineWidth: 1
                )
            
            
            if position == buzzel.activeCell {
                SelectedCellShape()
            }
            
            if node.value == buzzel.highLightedValue {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemBlue))
                    Text(node.text)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            } else {
                if buzzel.ignoredCell != position {
                    Text(node.text)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(node.color)
                }
            }
            
            if position == buzzel.animatedCell {
                
                    
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemBlue))
                    
                    if buzzel.animatedCellError {
                        ZStack {
                            Text("\(buzzel.animatedCellErrorValue)")
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
                        buzzel.normalGrid()
                    }
                }
                .zIndex(2)
            }
        }
        .frame(width: Global.cellWidth, height: Global.cellWidth)
        .onTapGesture {
            buzzel.selectCell(position)
        }
    }
}

struct LikeEffect: GeometryEffect {

    var offsetValue: Double // 0...1
    
    var animatableData: Double {
        get { offsetValue }
        set { offsetValue = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let reducedValue = offsetValue - floor(offsetValue)
        let value = 1.0-(cos(2*reducedValue*Double.pi)+1)/2

        let angle  = CGFloat(Double.pi*value*0.3)
        let translation   = CGFloat(20*value)
        let scaleFactor  = CGFloat(1+1*value)
        
        
        let affineTransform = CGAffineTransform(translationX: size.width*0.5, y: size.height*0.5)
        .rotated(by: CGFloat(angle))
        .translatedBy(x: -size.width*0.5+translation, y: -size.height*0.5-translation)
        .scaledBy(x: scaleFactor, y: scaleFactor)
        
        return ProjectionTransform(affineTransform)
    }
}
