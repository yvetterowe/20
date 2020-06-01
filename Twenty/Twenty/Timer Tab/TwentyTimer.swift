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
    func setTimerViewStateStore(_ store: TimerViewStateStore)
    func resume()
    func suspend()
}

final class RealTimer: TwentyTimer {
    
    private let timeInterval: TimeInterval
    private weak var timerViewStateStore: TimerViewStateStore!

    private lazy var backgroundTimer: BackgroundTimer = .init(timeInterval: timeInterval) { tickInterval in
        DispatchQueue.main.async {
            self.timerViewStateStore.send(.timerTicked(tickInterval: tickInterval))
        }
    }

    init(timeInterval: TimeInterval = 1) {
        self.timeInterval = timeInterval
    }
    
    // MARK: - TwentyTimer
    
    func setTimerViewStateStore(_ store: TimerViewStateStore) {
        self.timerViewStateStore = store
    }

    func resume() {
        backgroundTimer.resume()
    }
    
    func suspend() {
        backgroundTimer.suspend()
    }
}
