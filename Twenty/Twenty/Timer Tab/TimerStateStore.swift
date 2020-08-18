//
//  TimerStateStore.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

struct TimerState {
    let isActive: Bool
    let elapsedTime: DateInterval?
}

enum TimerAction {
    case toggleTimerButtonTapped
    case ticked(tickDate: Date, tickInterval: TimeInterval)
}

final class TimerStateStore: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published private(set) var state: TimerState
    
    var timerStatePublisher: AnyPublisher<TimerState, Never> {
        return $state.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    
    private lazy var backgroundTimer: BackgroundTimer = .init(timeInterval: timerInterval) { tickInterval in
        DispatchQueue.main.async {
            self.send(.ticked(tickDate: Date(), tickInterval: tickInterval))
        }
    }
    private let goalStoreWriter: GoalStoreWriter
    private let goalID: GoalID
    private let timerInterval: TimeInterval = 1
    
    init(initialState: TimerState, goalStoreWriter: GoalStoreWriter, goalID: GoalID) {
        self._state = .init(initialValue: initialState)
        self.goalStoreWriter = goalStoreWriter
        self.goalID = goalID
    }
    
    func send(_ action: TimerAction) {
        switch action {
        case .toggleTimerButtonTapped:
            if state.isActive {
                guard let currentElapsedTime = state.elapsedTime else {
                    fatalError()
                }
                _ = goalStoreWriter.appendTrackRecord(
                    .init(
                        id: UUID().uuidString,
                        timeSpan: currentElapsedTime
                    ),
                    forGoal: goalID
                )
                backgroundTimer.suspend()
            } else {
                backgroundTimer.resume()
            }
        
            state = .init(
                isActive: !state.isActive,
                elapsedTime: state.elapsedTime
            )
            
        case let .ticked(tickDate, _):
            state = .init(
                isActive: true,
                elapsedTime: .init(
                    start: state.elapsedTime?.start ?? tickDate,
                    end: tickDate
                )
            )
        }
    }
}
