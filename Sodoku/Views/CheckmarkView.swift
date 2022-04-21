//
//  CheckmarkView.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct CheckmarkView: View {
    var checked: Bool
    var body: some View {
        ZStack {
            Image(systemName: "rectangle")
                .font(.headline)
            if checked {
                Image(systemName: "checkmark")
                    .font(.title)
                    .foregroundColor(Color(.systemGreen))
                    .offset(x: 5, y: -5)
            }
        }
    }
}
