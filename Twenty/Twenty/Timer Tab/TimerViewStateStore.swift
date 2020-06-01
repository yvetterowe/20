//
//  TimerViewStateStore.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

typealias TimerViewStateStore = Store<TimerViewState, TimerViewAction, TimerViewContext>

enum TimerViewState {
    case loading
    case inactive(totalElapsedSeconds: TimeInterval)
    case active(currentSpan: DateInterval, totalElapsedSeconds: TimeInterval)
}

enum TimerViewAction {
    case goalLoaded(Goal)
    case timerButtonTapped
    case timerTicked(tickDate: Date, tickInterval: TimeInterval)
}

struct TimerViewContext {
    let currentDate: Date
    let timer: TwentyTimer
}

func timerViewReducer(state: inout TimerViewState, action: TimerViewAction, context: TimerViewContext) {
    switch action {
    case let .goalLoaded(goal):
        switch state {
        case .loading:
            state = .inactive(
                totalElapsedSeconds: goal.totalTimeSpent(on: .init(context.currentDate.stripTime()))
            )
        case .inactive, .active:
            fatalError("View should not be in \(state) state for \(action) action")
        }
    
    case .timerButtonTapped:
        switch state {
        case .loading:
            fatalError("View should not be in \(state) state for \(action) action")
        case let .inactive(totalElapsedSeconds):
            let now = Date()
            state = .active(
                currentSpan: .init(start: now, end: now),
                totalElapsedSeconds: totalElapsedSeconds
            )
            context.timer.resume()
        case let .active(currentSpan, totalElapsedSeconds):
            // Timer goes from active to inactive
            state = .inactive(totalElapsedSeconds: totalElapsedSeconds)
            context.timer.suspend()
            print("paused! last active: \(currentSpan.duration) \(currentSpan)")
        }
        
    case let .timerTicked(tickDate, tickInterval):
        switch state {
        case .loading:
            fatalError("View should not be in \(state) state for \(action) action")
        case let .inactive(elapsedTime):
            // First tick when timer goes from inactive to active
            state = .active(
                currentSpan: .init(start: tickDate, end: tickDate),
                totalElapsedSeconds: elapsedTime
            )
        case let .active(currentSpan, totalElapsedSeconds):
            // Non-first tick
            state = .active(
                currentSpan: .init(start: currentSpan.start, end: tickDate),
                totalElapsedSeconds: totalElapsedSeconds + tickInterval
            )
        }
    }
}
