//
//  StatefulTimerTabView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct StatefulTimerTabView: View {
    
    struct Context {
        let timerStateStore: TimerStateStore
        let goalPublisher: GoalPublisher
        let timer: TwentyTimer
        let initialSelectedDay: Date.Day
        let selectDayStore: SelectDayStore
    }
    
    private let context: Context
    
    init(context: Context) {
        self.context = context
    }
    
    var body: some View {
        VStack {
            StatefulSelectDayHeader(store: context.selectDayStore)
            StatefulTimerWatchView(context: context)
            StatefulTimerButton(timer: context.timer)
        }
    }
}

//struct StatefulTimerTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulTimerTabView(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.activeState))
//    }
//}
