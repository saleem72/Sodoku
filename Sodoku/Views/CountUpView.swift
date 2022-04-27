//
//  CountUpView.swift
//  Sodoku
//
//  Created by Yousef on 4/26/22.
//

import SwiftUI
import Combine





struct CountUpView: View {
    
    
    @StateObject var seconds: TimeSpan = .init()
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                Text(seconds.toDescription)
                    .font(.title)
                
                HStack(spacing: 32) {
                    Button(action: {
                        seconds.start()
                    }, label: {
                        Text("Start")
                    })
                    
                    Button(action: {
                        seconds.pause()
                    }, label: {
                        Text("Pause")
                    })
                    
                    Button(action: {
                        seconds.resume()
                    }, label: {
                        Text("Resume")
                    })
                }
            }
            .onAppear {
                seconds.resume()
            }
            .onDisappear {
                seconds.pause()
            }
        }
    }
}

private extension CountUpView {
    func calculateTime() {
//        ellapsedTime
//        seconds.value += 1
    }
}

struct CountUpView_Previews: PreviewProvider {
    static var previews: some View {
        CountUpView()
    }
}
