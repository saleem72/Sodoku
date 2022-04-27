//
//  MistakeView.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import SwiftUI

struct MistakeView: View {
    var count: Int
    
    @State private var attempts: Int = 0
    @State private var animated: Bool = false
    
    var animatableData: Int {
        get { return attempts }
        set { attempts = newValue }
    }
    
    var body: some View {
        VStack {
            Text("Errors")
            
            Spacer(minLength: 0)
            
            HStack {
                ForEach(1...5, id: \.self) { idx in
                    MistakeCellView(idx: idx, count: count)
                }
            }
        }
        .zIndex(5)
    }
}
