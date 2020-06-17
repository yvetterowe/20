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
    func resume()
    func suspend()
}

final class RealTimer: TwentyTimer {
    
    private let timeInterval: TimeInterval
    private let timerStateStore: TimerStateStore

    private lazy var backgroundTimer: BackgroundTimer = .init(timeInterval: timeInterval) { tickInterval in
        DispatchQueue.main.async {
            self.timerStateStore.send(.ticked(tickDate: Date(), tickInterval: tickInterval))
        }
    }

    init(timeInterval: TimeInterval = 1, store: TimerStateStore) {
        self.timeInterval = timeInterval
        self.timerStateStore = store
    }
    
    // MARK: - TwentyTimer
    
    func resume() {
        backgroundTimer.resume()
        timerStateStore.send(.resume)
    }
    
    func suspend() {
        backgroundTimer.suspend()
        timerStateStore.send(.suspend)
    }
}
