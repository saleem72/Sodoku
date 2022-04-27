//
//  MistakeCellView.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import SwiftUI

struct MistakeCellView: View {
    var idx: Int
    var count: Int
    @State private var animated: Bool = false
    var body: some View {
        Group {
            if idx < count {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
            } else if idx == count {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                                .offset(x: animated ? 0 : 50, y: animated ? 0 : 20)
//                    .scaleEffect(animated ? 1 : 1.3)
                    .rotation3DEffect(
                        Angle(degrees: animated ? 0 : 45),
                        axis: (x: 0.0, y: 1.0, z: 1.0)
                    )
                    .animation(.spring())
                    .onAppear {
                        animated = true
                    }
            } else {
                Image(systemName: "xmark")
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
        .font(Font.subheadline.weight(Font.Weight.bold))
    }
}
