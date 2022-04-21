//
//  ContentView.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var dataCenter = DataCenter()
    
    var body: some View {
        HomeScreen()
            .environmentObject(dataCenter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
