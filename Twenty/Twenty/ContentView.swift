//
//  ContentView.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let timer: TwentyTimer
    @State private var selection = 0
    
    init(timer: TwentyTimer) {
        self.timer = timer
    }
    
    var body: some View {
        TabView(selection: $selection){
            TimerTabView(initialTimerViewState: .inactive(0), timer: timer)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(timer: MockTimer())
    }
}
