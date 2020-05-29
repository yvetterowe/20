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

protocol Timer {
    var elapsedTime: AnyPublisher<TimeInterval, Never> { get }
    func sendAction(_ timerAction: TimerAction)
}
