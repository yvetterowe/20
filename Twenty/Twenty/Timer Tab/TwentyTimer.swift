//
//  TwentyTimer.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

protocol TwentyTimer {
    func setTimerStateStore(_ store: TimerStateStore)
    func resume()
    func suspend()
}

final class RealTimer: TwentyTimer {
    
    private let timeInterval: TimeInterval
    private weak var timerStateStore: TimerStateStore!

    private lazy var backgroundTimer: BackgroundTimer = .init(timeInterval: timeInterval) { tickInterval in
        DispatchQueue.main.async {
            self.timerStateStore.send(.timerTicked(tickInterval: tickInterval))
        }
    }

    init(timeInterval: TimeInterval = 1) {
        self.timeInterval = timeInterval
    }
    
    // MARK: - TwentyTimer
    
    func setTimerStateStore(_ store: TimerStateStore) {
        self.timerStateStore = store
    }

    func resume() {
        backgroundTimer.resume()
    }
    
    func suspend() {
        backgroundTimer.suspend()
    }
}
