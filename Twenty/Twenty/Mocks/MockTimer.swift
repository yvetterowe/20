//
//  Mocks.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

final class MockTimer: TwentyTimer {
    @Published private var internalState: TimerState = .inactive(0)
    
    var state: AnyPublisher<TimerState, Never> {
        return $internalState.eraseToAnyPublisher()
    }
    
    func sendAction(_ timerAction: TimerAction) {
        switch(internalState, timerAction) {
        case (let .inactive(time), .start):
            internalState = .active(time+1)
        case (let .active(time), .pause):
            internalState = .inactive(time)
        default:
            fatalError()
        }
    }
}

let mockCurrentDate: Date = DateComponents(calendar: .current, year: 2020, month: 5, day: 30, hour: 14, minute: 30, second: 10).date!
