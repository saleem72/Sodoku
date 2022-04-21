//
//  BlurView.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style = .regular) {
        self.style = style
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}

