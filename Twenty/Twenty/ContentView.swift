//
//  ContentView.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let timerTabContext: StatefulTimerTabView.Context

    @State private var selection = 0

    init(timerTabContext: StatefulTimerTabView.Context) {
        self.timerTabContext = timerTabContext
    }
    
    var body: some View {
        TabView(selection: $selection){
            StatefulTimerTabView(context: timerTabContext)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("TwentyTimer")
                    }
                }
                .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
                }
                .tag(1)
        }
    }
}
