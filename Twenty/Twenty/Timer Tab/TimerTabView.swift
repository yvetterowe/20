//
//  TimerTabView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct TimerTabView: View {
    
    private let timer: TwentyTimer
    private let timerStateStore: TimerStateStore
    
    init(
        goalPublisher: GoalPublisher,
        timer: TwentyTimer,
        currentDate: Date
    ) {
        self.timer = timer
        self.timerStateStore = .init(
            goalPublisher: goalPublisher,
            timer: timer,
            currentDate: currentDate
        )
    }
    
    var body: some View {
        VStack {
            StatefulTimerView(timerStateStore: timerStateStore)
            StatefulTimerButton(timerStateStore: timerStateStore, timer: timer)
        }
    }
}
