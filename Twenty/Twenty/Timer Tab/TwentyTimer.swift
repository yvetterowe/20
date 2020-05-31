//
//  TwentyTimer.swift
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
    case loading
    case inactive(TimeInterval)
    case active(TimeInterval)
}

protocol TwentyTimer {
    var state: AnyPublisher<TimerState, Never> { get }
    func sendAction(_ timerAction: TimerAction)
}

final class RealTimer: TwentyTimer {
    private let timeInterval: TimeInterval
    @Published private var internalState: TimerState {
        didSet {
            print("\(internalState)")
        }
    }
    
    private lazy var backgroundTimer: BackgroundTimer = .init(timeInterval: timeInterval) {
        guard case let .active(totalActiveTime) = self.internalState else {
            return
        }
        self.internalState = .active(totalActiveTime + self.timeInterval)
    }
    
    init(timeInterval: TimeInterval = 1, goalPublisher: GoalPublisher, currentDate: Date) {
        self.internalState = .loading
        self.timeInterval = timeInterval
        
        _ = goalPublisher.sink { goal in
            self.internalState = .inactive(goal.totalTimeSpent(on: currentDate))
        }
    }
    
    // MARK: - TwentyTimer
    
    var state: AnyPublisher<TimerState, Never> {
        return $internalState
            .eraseToAnyPublisher()
    }
    
    func sendAction(_ timerAction: TimerAction) {
        switch timerAction {
        case .start:
            guard case let .inactive(timeInterval) = internalState else {
                return
            }
            internalState = .active(timeInterval)
            backgroundTimer.resume()
            
        case .pause:
            guard case let .active(timeInterval) = internalState else {
                return
            }
            internalState = .inactive(timeInterval)
            backgroundTimer.suspend()
        }
    }
    
}
