//
//  ContentView.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let goalPublisher: GoalPublisher
    private let timerStateStore: TimerStateStore
    private let timer: TwentyTimer
    
    @State private var selection = 0
    
    init(goalPublisher: GoalPublisher, timerStateStore: TimerStateStore, timer: TwentyTimer) {
        self.goalPublisher = goalPublisher
        self.timerStateStore = timerStateStore
        self.timer = timer
    }
    
    var body: some View {
        TabView(selection: $selection){
            StatefulTimerTabView(timerStateStore: timerStateStore, goalPublisher: goalPublisher, timer: timer)
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(goalPublisher: GoalPublisher, TimerStateStore: <#T##TimerStateStore#>)
//    }
//}
