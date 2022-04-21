//
//  LinearGradient+Extension.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

extension LinearGradient {
    static let monoGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color.white.opacity(0.5),
            Color(.lightGray).opacity(0.5),
            Color(.lightGray)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let coloredGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color.white.opacity(0.5),
            Color(.systemYellow).opacity(0.5),
            Color(.systemYellow)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
}
