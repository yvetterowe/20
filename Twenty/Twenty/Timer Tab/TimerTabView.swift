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
    
    private let timer: Timer
    
    init(timer: Timer) {
        self.timer = timer
    }
    
    var body: some View {
        StatefulTimerButton(viewState: .inactive, timer: timer)
    }
}

struct TimerTabView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTabView(timer: MockTimer())
    }
}
