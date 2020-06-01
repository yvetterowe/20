//
//  TimerTabView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct TimerTabView: View {
    
    private let timerStateStore: TimerStateStore
    
    init(timerStateStore: TimerStateStore) {
        self.timerStateStore = timerStateStore
    }
    
    var body: some View {
        VStack {
            StatefulTimerView(timerStateStore: timerStateStore)
            StatefulTimerButton(timerStateStore: timerStateStore)
        }
    }
}

struct TimerTabView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTabView(timerStateStore: MockTimerFactory.timerStateStore(.active(100)))
    }
}
