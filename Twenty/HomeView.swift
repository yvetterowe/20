//
//  HomeView.swift
//  Twenty
//
//  Created by Effy Zhang on 6/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct HomeView: View {
        private let timerTabContext: StatefulTimerTabView.Context
        
    @State private var selection = 0

        init(timerTabContext: StatefulTimerTabView.Context) {
            self.timerTabContext = timerTabContext
        }
        
    var body: some View {
//        Text("Hello, World!")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(goalPublisher: GoalPublisher, TimerStateStore: <#T##TimerStateStore#>)
    }
}

