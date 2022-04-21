//
//  RateView.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct RateView: View {
    
    var rate: Int
    
    var body: some View {
        HStack {
            ForEach(1...3, id:\.self) { idx in
                Group {
                    if idx <= rate {
                        LinearGradient.coloredGradient
                            .mask(Image(systemName: "star.fill"))
                            
                    } else {
                        LinearGradient.monoGradient
                            .mask(Image(systemName: "star.fill"))
                    }
                }
                .frame(width: 24, height: 24)
                
            }
        }
    }
}
