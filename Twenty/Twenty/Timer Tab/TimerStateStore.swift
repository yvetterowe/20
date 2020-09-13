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

protocol TimerStateReader {
    var timerStatePublisher: AnyPublisher<TimerState, Never> { get }
}

protocol TimerStateWriter {
    func send(_ action: TimerAction)
}

final class TimerStateStore: TimerStateReader, TimerStateWriter {
    
    // MARK: - Private Properties
    
    private var state: CurrentValueSubject<TimerState, Never>
    
    private lazy var backgroundTimer: BackgroundTimer = .init(timeInterval: timerInterval) { tickInterval in
        DispatchQueue.main.async { [unowned self] in
            guard case let .active(interval) = self.state.value else {
                fatalError("Timer must already be in active state")
            }
            self.state.value = .active(
                .init(
                    start: interval.start,
                    duration: interval.duration + tickInterval
                )
            )
            
        }
    }
    
    private let timerInterval: TimeInterval
    
    init(initialState: TimerState, timerInterval: TimeInterval = 1) {
        self.state = .init(initialState)
        self.timerInterval = timerInterval
    }
    
    // MARK: - TimerStateReader
        
    var timerStatePublisher: AnyPublisher<TimerState, Never> {
        return state.eraseToAnyPublisher()
    }
    
    // MARK: - TimerStateWriter
    
    func send(_ action: TimerAction) {
        switch action {
        case .toggleTimerButtonTapped:
            switch state.value {
            case let .active(interval):
                state.value = .inactive(interval)
                backgroundTimer.suspend()
            
            case let .inactive(interval):
                state.value = .active(interval)
                backgroundTimer.resume()
            }
        }
    }
}
