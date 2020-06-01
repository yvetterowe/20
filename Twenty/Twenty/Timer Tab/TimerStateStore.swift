//
//  TimerStateStore.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

typealias TimerStateStore = Store<TimerState, TimerViewAction, TimerViewContext>

enum TimerState {
    case loading
    case inactive(TimeInterval)
    case active(TimeInterval)
}

enum TimerViewAction {
    case goalLoaded(Goal)
    case timerButtonTapped
    case timerTicked(tickInterval: TimeInterval)
}

struct TimerViewContext {
    let currentDate: Date
    let timer: TwentyTimer
}

func timerViewReducer(state: inout TimerState, action: TimerViewAction, context: TimerViewContext) {
    switch action {
    case let .goalLoaded(goal):
        switch state {
        case .loading:
            state = .inactive(goal.totalTimeSpent(on: .init(context.currentDate.stripTime())))
        case .inactive, .active:
            fatalError("View should not be in \(state) state for \(action) action")
        }
    
    case .timerButtonTapped:
        switch state {
        case .loading:
            fatalError("View should not be in \(state) state for \(action) action")
        case let .inactive(elapsedTime):
            state = .active(elapsedTime)
            context.timer.resume()
        case let .active(elapsedTime):
            state = .inactive(elapsedTime)
            context.timer.suspend()
        }
        
    case let .timerTicked(tickInterval):
        switch state {
        case .loading, .inactive:
            fatalError("View should not be in \(state) state for \(action) action")
        case let .active(elapsedTime):
            state = .active(elapsedTime + tickInterval)
        }
    }
}
