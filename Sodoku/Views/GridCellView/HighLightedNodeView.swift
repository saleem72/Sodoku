//
//  HighLightedNodeView.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import SwiftUI

struct HighLightedNodeView: View {
    var node: NodeTemplate
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBlue))
            Text(node.text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}
