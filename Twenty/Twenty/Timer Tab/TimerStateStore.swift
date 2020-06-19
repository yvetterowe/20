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
    
    enum ActiveState: Equatable {
        case inactive
        case active(currentElapsedTime: DateInterval)
    }
    
    var activeState: ActiveState {
        didSet {
            switch(oldValue, activeState) {
            case (_, .inactive):
                totalElapsedTime = 0
            case (.inactive, let .active(currentElapsedTime)):
                totalElapsedTime += currentElapsedTime.duration
            case (let .active(previousElapsedTime), let .active(currentElapsedTime)):
                guard previousElapsedTime.start == currentElapsedTime.start else {
                    fatalError("Inconsistent start time \(previousElapsedTime.start) \(currentElapsedTime.start)")
                }
                totalElapsedTime += currentElapsedTime.end.timeIntervalSince(previousElapsedTime.end)
            }
        }
    }
    
    private(set) var totalElapsedTime: TimeInterval
}


enum TimerAction {
    case resume
    case suspend
    case ticked(tickDate: Date, tickInterval: TimeInterval)
}

final class TimerStateStore: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published private(set) var state: TimerState
    
    var timerStatePublisher: AnyPublisher<TimerState, Never> {
        return $state.eraseToAnyPublisher()
    }
    
    // MARK: - Private Properties
    
    private let goalStoreWriter: GoalStoreWriter
    private let goalID: GoalID
    
    init(initialState: TimerState, goalStoreWriter: GoalStoreWriter, goalID: GoalID) {
        self._state = .init(initialValue: initialState)
        self.goalStoreWriter = goalStoreWriter
        self.goalID = goalID
    }
    
    func send(_ action: TimerAction) {
        switch action {
        case .resume:
            guard case .inactive = state.activeState else {
                fatalError()
            }
            state.activeState = .active(currentElapsedTime: .init(start: Date(), duration: 0))
                
        case .suspend:
            guard case let .active(currentElapsedTime) = state.activeState else {
                 fatalError()
            }
            state.activeState = .inactive
            print("paused! last active: \(currentElapsedTime.duration) \(currentElapsedTime)")
            goalStoreWriter.appendTrackRecord(
                .init(
                    id: UUID().uuidString,
                    timeSpan: currentElapsedTime
                ),
                forGoal: goalID
            )
        
        case let .ticked(tickDate, _):
            switch state.activeState {
            case .inactive:
                break
            case let .active(currentElapsedTime):
                state.activeState = .active(
                    currentElapsedTime: .init(
                        start: currentElapsedTime.start,
                        end: tickDate
                    )
                )
            }
        }
    }
}
