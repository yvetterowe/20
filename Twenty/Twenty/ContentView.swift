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

    init(timerTabContext: Context) {
        self.timerTabContext = timerTabContext
    }
    
    var body: some View {
        StatefulDayView(
            context: timerTabContext,
            viewStateStore: ObservableWrapper(
                publisher: DayViewModelStore(
                    selectedDayPublisher: timerTabContext.selectDayStore.selectDayPublisher,
                    todayPublisher: timerTabContext.todayPublisher,
                    goalPublisher: timerTabContext.goalPublisher
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
    }
}
