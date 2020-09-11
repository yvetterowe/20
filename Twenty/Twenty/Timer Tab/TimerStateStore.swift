//
//  TimerStateStore.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

enum TimerState {
    case active(DateInterval)
    case inactive(DateInterval)
}

enum TimerAction {
    case toggleTimerButtonTapped
}

final class TimerStateStore: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published private(set) var state: TimerState
    
    var timerStatePublisher: AnyPublisher<TimerState, Never> {
        return $state.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    
    private lazy var backgroundTimer: BackgroundTimer = .init(timeInterval: timerInterval) { tickInterval in
        DispatchQueue.main.async { [unowned self] in
            guard case let .active(interval) = self.state else {
                fatalError("Timer must already be in active state")
            }
            self.state = .active(
                .init(
                    start: interval.start,
                    duration: interval.duration + tickInterval
                )
            )
            
        }
    }
    
    private let timerInterval: TimeInterval
    
    init(initialState: TimerState, timerInterval: TimeInterval = 1) {
        self._state = .init(initialValue: initialState)
        self.timerInterval = timerInterval
    }
    
    func send(_ action: TimerAction) {
        switch action {
        case .toggleTimerButtonTapped:
            switch state {
            case let .active(interval):
                state = .inactive(interval)
                backgroundTimer.suspend()
            
            case let .inactive(interval):
                state = .active(interval)
                backgroundTimer.resume()
            }
        }
    }
}
