//
//  ExamplesListScreen.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct ExamplesListScreen: View {
    
    var examples: [Example]
    var label: String
    
    @EnvironmentObject private var dataCenter: DataCenter
    
    init(label: String, examples: [Example]) {
        self.label = label
        self.examples = examples
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(examples) { example in
                    NavigationLink(
                        destination: SolvingBuzzelScreen(buzzel: example),
                        label: {
                            ExampleCard(example: dataCenter.statistic(for: example))
                        })
                    
                }
            }
            .padding()
        }
        .navigationTitle(label)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExamplesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExamplesListScreen(label: "Hard", examples: [Example.example])
                .environmentObject(DataCenter())
        }
    }
}
