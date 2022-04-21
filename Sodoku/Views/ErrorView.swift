//
//  ErrorView.swift
//  Sodoku
//
//  Created by Yousef on 4/21/22.
//

import SwiftUI

struct ErrorView: View {
    var message: String
    var onDismiss: () -> Void
    
    init(message: String, onDismiss: @escaping () -> Void) {
        self.message = message
        self.onDismiss = onDismiss
    }
    
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            Text(message)
                .font(.system(size: 34, weight: .semibold))
                .foregroundColor(.primary)
            Spacer(minLength: 0)
            Button(action: {
                onDismiss()
            }, label: {
                Text("Ok")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(width: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGreen))
                    )
            })
            Spacer()
                .frame(height: 100)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            BlurView()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Can't find file") { }
            .preferredColorScheme(.dark)
    }
}
