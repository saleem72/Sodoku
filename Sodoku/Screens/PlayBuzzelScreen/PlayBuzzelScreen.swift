//
//  PlayBuzzelScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct PlayBuzzelScreen: View {
    
    @StateObject private var buzzel: SudokuPlayer
    @EnvironmentObject var dataCenter: DataCenter
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var isPausing: Bool = false
    
    init(buzzel: Example) {
        self._buzzel = StateObject(wrappedValue: SudokuPlayer(sudoku: buzzel))
    }
    
    var body: some View {
        ZStack {
            if buzzel.showWinning {
                winningView
            } else {
                content()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            buzzel.dataCenter = dataCenter
        }
    }
}

extension PlayBuzzelScreen {
    
    @ViewBuilder
    private func content() -> some View {
        if isPausing {
            pausingView
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                .animation(.default)
        } else {
            playingZone
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .leading),
                        removal: .move(edge: .trailing)
                    ))
                .animation(.default)
        }
    }
    
    private var winningView: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.pallet.pink,
                    Color(red: 50/255, green: 25/255, blue: 25/255, opacity: 1)
                ]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("You have won!\nIn\(buzzel.counterValue)")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Ok")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .frame(width: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 2)
                        )
                })
            }
        }
    }
    
    private var pausingView: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.pallet.pink,
                    Color(red: 50/255, green: 25/255, blue: 25/255, opacity: 1)
                ]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                Button(action: {
                    isPausing = false
                }, label: {
                    Text("Resume")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .frame(width: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 2)
                        )
                })
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Menu")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .frame(width: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 2)
                        )
                })
            }
        }
    }
    
    private var errorOverlay: some View {
        MistakeView(count: buzzel.errorCount)
    }
    
    private var playingZone: some View {
        VStack(spacing: 32) {
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Level \(buzzel.example.name)")
                        Text(buzzel.example.type.title)
                    }
                    
                    Spacer(minLength: 0)
                    VStack {
                        Text("Time")
                        Text(buzzel.counterValue)
                    }
                    .frame(width: 100)
                }
                .padding(.horizontal)
                .overlay(errorOverlay)
                
                GridForPlayingView(buzzel: buzzel)
                    .zIndex(1.0)
            }
            
            PlayingKeyBoard { key in
                buzzel.keyWasTapped(key)
                    
            }
            
            HStack(spacing: 8) {
                Button(action: {
                    isPausing = true
                }, label: {
                    Image(systemName: "pause.fill")
                        .frame(width: Global.keyboardKeyWidth, height: Global.keyboardKeyWidth)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke()
                        )
                })
                
                Button(action: {}, label: {
                    Image(systemName: "arrow.counterclockwise")
                        .frame(width: Global.keyboardKeyWidth, height: Global.keyboardKeyWidth)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke()
                        )
                })
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            
            Spacer(minLength: 0)
        }
        .padding(.top, 32)
        .onAppear {
            buzzel.counter.resume()
        }
        .onDisappear() {
            buzzel.counter.pause()
        }
    }
}

struct PlayBuzzelScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayBuzzelScreen(buzzel: Example.example)
        }
        .environmentObject(DataCenter())
    }
}





struct GridCellView: View {
    
    @Binding var node: NodeTemplate
    var position: GridCell
    @ObservedObject var buzzel: SudokuPlayer
    
    @State private var likes: Double = 100
    
    init(node: Binding<NodeTemplate>, position: GridCell, buzzel: SudokuPlayer) {
        self._node = node
        self.position = position
        self.buzzel = buzzel
    }
    
    var body: some View {
        ZStack {
            NodeBackgroundView()
            
            
            if position == buzzel.activeCell {
                SelectedCellShape()
            }
            
            if node.isHighLighted && !node.isSparke {
                HighLightedNodeView(node: node)
            } else {
                if buzzel.ignoredCell != position {
                    Text(node.text)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(node.color)
                }
            }
            
            if node.isAnimated {
                AnimatedNodeView(node: $node, buzzel: buzzel)
            }
            
            if node.isSparke {
                NodeSparklingView(node: $node, buzzel: buzzel)
            }
        }
        .frame(width: Global.cellWidth, height: Global.cellWidth)
        .onTapGesture {
            buzzel.selectCell(position)
        }
    }
}







struct NodeSparklingView: View {
    
    @Binding var node: NodeTemplate
    @ObservedObject var buzzel: SudokuPlayer
    
    @State private var sparklingDegree: Double = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
            RoundedRectangle(cornerRadius: 8)
                .stroke()
            Text(node.text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
        }
        .compositingGroup()
        .rotation3DEffect(
            Angle(degrees: sparklingDegree),
            axis: (x: 0.0, y: 0.0, z: 1.0)
        )
        .onAppear {
            withAnimation(Animation.easeIn(duration: 0.3)) {
                sparklingDegree = 45
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(Animation.easeIn(duration: 0.3)) {
                    sparklingDegree = -45
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(Animation.easeIn(duration: 0.3)) {
                    sparklingDegree = 0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                node.isSparke = false
                
//                buzzel.checkForEndGame()
            }
        }
    }
}






