//
//  ExamplesListScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct ExamplesListScreen: View {
    
    var level: GameLevel
    
    @EnvironmentObject private var dataCenter: DataCenter
    
    init(level: GameLevel) {
        self.level = level
    }
    
    var examples: [Example] {
        dataCenter.examples.filter({$0.type == level})
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                
                ForEach(examples) { example in
                    if dataCenter.mode == .solving {
                        NavigationLink(
                            destination: SolvingBuzzelScreen(buzzel: example),
                            label: {
                                ExampleCard(example: dataCenter.statistic(for: example))
                            })
                    } else {
                        NavigationLink(
                            destination: PlayBuzzelScreen(buzzel: example),
                            label: {
                                ExampleCard(example: dataCenter.statistic(for: example))
                            })
                    }
                }
            }
            .padding()
        }
        .navigationTitle(level.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExamplesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExamplesListScreen(level: .hard)
                .environmentObject(DataCenter())
        }
    }
}
