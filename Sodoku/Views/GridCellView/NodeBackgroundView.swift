//
//  NodeBackgroundView.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import SwiftUI

struct NodeBackgroundView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemBackground))
            Rectangle()
                .stroke(
                    Color.pallet.pink.opacity(0.6),
                    lineWidth: 1
                )
        }
    }
}
