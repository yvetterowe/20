//
//  Mocks.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

struct MockTimer: Timer {
    var elapsedTime: AnyPublisher<TimeInterval, Never> { fatalError() }
    
    func sendAction(_ timerAction: TimerAction) {
        switch timerAction {
        case .start:
            print("timer start")
        case .pause:
            print("timer pause")
        }
    }
}
