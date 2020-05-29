//
//  Timer.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

enum TimerAction {
    case start
    case pause
}

enum TimerState {
    case inactive(TimeInterval)
    case active(TimeInterval)
}

protocol Timer {
    var state: AnyPublisher<TimerState, Never> { get }
    func sendAction(_ timerAction: TimerAction)
}
