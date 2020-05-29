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
    private let timerViewStateStore: TimerViewStateStore
    
    init(initialTimerViewState: StatefulTimerView.ViewState, timer: TwentyTimer) {
        self.timer = timer
        self.timerViewStateStore = .init(initialState: initialTimerViewState, timer: timer)
    }
    
    var body: some View {
        VStack {
            StatefulTimerView(viewStateStore: timerViewStateStore)
            StatefulTimerButton(viewState: .inactive, timer: timer)
        }
    }
}

struct TimerTabView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTabView(initialTimerViewState: .inactive(0), timer: MockTimer())
    }
}
