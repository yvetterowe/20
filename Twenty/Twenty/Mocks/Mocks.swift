//
//  Mocks.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

final class MockTimer: Timer {
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
