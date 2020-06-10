//
//  StatefulTimerTabView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct StatefulTimerTabView: View {
    
    private let timerStateStore: TimerStateStore
    private let goalPublisher: GoalPublisher
    private let timer: TwentyTimer
    
    init(timerStateStore: TimerStateStore, goalPublisher: GoalPublisher, timer: TwentyTimer) {
        self.timerStateStore = timerStateStore
        self.goalPublisher = goalPublisher
        self.timer = timer
    }
    
    var body: some View {
        VStack {
            StatefulTimerWatchView(timerStateStore: timerStateStore, goalPublisher: goalPublisher)
            StatefulTimerButton(timer: timer)
        }
    }
}

//struct StatefulTimerTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulTimerTabView(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.activeState))
//    }
//}
