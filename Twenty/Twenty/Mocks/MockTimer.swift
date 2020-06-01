//
//  Mocks.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

enum MockTimerFactory {
    static let timer: TwentyTimer = MockTimer()
    static let currentDate: Date = DateComponents(
        calendar: .current, year: 2020, month: 5, day: 30, hour: 14, minute: 30, second: 10
    ).date!

    static let activeState: TimerViewState = .active(
        goalID: MockGoalFactory.mockGoals.first!.id,
        currentSpan: .init(start: MockTimerFactory.currentDate.advanced(by: -40), duration: 40),
        totalElapsedSeconds: 100
    )
    
    static let inactiveState: TimerViewState = .inactive(
        goalID: MockGoalFactory.mockGoals.first!.id,
        totalElapsedSeconds: 100
    )
    
    static func timerViewStateStore(_ initialState: TimerViewState) -> TimerViewStateStore {
        return .init(
            initialState: initialState,
            reducer: { (_, _, _) in },
            context: MockTimerFactory.timerContext
        )
    }
    
    static let timerContext: TimerViewContext = .init(
        currentDate: MockTimerFactory.currentDate,
        timer: MockTimerFactory.timer
    )
}

private final class MockTimer: TwentyTimer {
    func setTimerViewStateStore(_ store: TimerViewStateStore) {}
    func resume() {}
    func suspend() {}
}
