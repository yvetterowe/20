//
//  TimerTabView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct TimerTabView: View {
    
    private let timerViewStateStore: TimerViewStateStore
    
    init(timerViewStateStore: TimerViewStateStore) {
        self.timerViewStateStore = timerViewStateStore
    }
    
    var body: some View {
        VStack {
            StatefulTimerWatchView(timerViewStateStore: timerViewStateStore)
            StatefulTimerButton(timerViewStateStore: timerViewStateStore)
        }
    }
}

struct TimerTabView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTabView(timerViewStateStore: MockTimerFactory.timerViewStateStore(.active(100)))
    }
}
