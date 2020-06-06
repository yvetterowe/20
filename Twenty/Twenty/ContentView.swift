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
    private let timerViewStateStore: TimerViewStateStore
    @State private var selection = 0
    
    init(goalPublisher: GoalPublisher, timerViewStateStore: TimerViewStateStore) {
        self.goalPublisher = goalPublisher
        self.timerViewStateStore = timerViewStateStore
    }
    
    var body: some View {
        TabView(selection: $selection){
            StatefulTimerTabView(timerViewStateStore: timerViewStateStore)
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
//        ContentView(goalPublisher: GoalPublisher, timerViewStateStore: <#T##TimerViewStateStore#>)
//    }
//}
