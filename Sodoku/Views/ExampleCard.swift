//
//  ExampleCard.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct ExampleCard: View {
    
    var example: Statistic
    
    var body: some View {
        HStack(alignment: .top) {
            Text(example.name)
                .padding(8)
                .background(
                    Circle()
                        .stroke()
                )
            HStack(spacing: 16) {
                VStack {
                    Text("last time".uppercased())
                    Text(example.lastTime)
                }
                VStack {
                    Text("best time".uppercased())
                    Text(example.bestTime)
                }
            }
            .frame(maxWidth: .infinity)
            VStack {
                RateView(rate: example.rate)
                
                CheckmarkView(checked: example.isDone)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color.primary)
    }
}
