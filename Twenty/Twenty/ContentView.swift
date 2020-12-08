//
//  ContentView.swift
//  Twenty
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    private let timerTabContext: Context

    @State private var selection = 0

    init(timerTabContext: Context) {
        self.timerTabContext = timerTabContext
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
                
                let timerStateStore = TimerStateStore(initialState: .inactive(.init()))
                let timerViewStateStore = TimerViewStateStore(
                    timerStatePublisher: timerStateStore.timerStatePublisher,
                    timerStateWriter: timerStateStore,
                    goalStoreWriter: timerTabContext.goalStoreWriter,
                    goalID: timerTabContext.goalID
                )
                
                StatefulTimerView(
                    viewStateReader: .init(publisher: timerViewStateStore.publisher),
                    timerViewModelWriter: timerViewStateStore,
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
