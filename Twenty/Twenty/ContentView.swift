//
//  ContentView.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let timerTabContext: Context
    private let timerStateStore: TimerStateStore

    @State private var selection = 0

    init(timerTabContext: Context) {
        self.timerTabContext = timerTabContext
        self.timerStateStore = .init(initialState: .inactive(.init()))
    }
    
    var body: some View {
        TabView(selection: $selection) {
            StatefulDayView(
                context: timerTabContext,
                viewStateStore: ObservableWrapper(
                    publisher: DayViewModelStore(
                        selectedDayPublisher: timerTabContext.selectDayStore.selectDayPublisher,
                        todayPublisher: timerTabContext.todayPublisher
                    ).publisher
                )
            ) { presentingTimer in
                StatefulTimerView(
                    viewStateStore: .init(
                        timerStatePublisher: timerStateStore.timerStatePublisher,
                        timerStateWriter: timerStateStore,
                        goalStoreWriter: timerTabContext.goalStoreWriter,
                        goalID: timerTabContext.goalID
                    ),
                    presentingTimer: presentingTimer
                )
            }
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
