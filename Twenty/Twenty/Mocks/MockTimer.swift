//
//  Mocks.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

enum MockTimerFactory {
    static let calendar: Calendar = .current
    static let timer: TwentyTimer = MockTimer()
    static let currentDate: Date = DateComponents(
        calendar: calendar, year: 2020, month: 5, day: 30, hour: 0, minute: 0, second: 0
    ).date!

//    static let activeState: TimerViewState = .init(
//        selectedDay: currentDate.asDay(in: calendar),
//        today: currentDate.asDay(in: calendar),
//        goalState: .loaded(MockGoalFactory.mockGoals.first!),
//        timerState: .active(currentElapsedTime: .init(start: MockTimerFactory.currentDate.advanced(by: -40), duration: 40))
//    )
//    
//    static let inactiveState: TimerViewState = .init(
//        selectedDay: currentDate.asDay(in: calendar),
//        today: currentDate.asDay(in: calendar),
//        goalState: .loaded(MockGoalFactory.mockGoals.first!),
//        timerState: .inactive
//    )
//    
//    static func timerStateStore(_ initialState: TimerState) -> TimerStateStore {
//        return .init(
//            initialState: initialState,
//            reducer: { (_, _, _) in },
//            context: MockTimerFactory.timerContext
//        )
//    }
//    
//    static func TimerStateStore(_ initialState: TimerViewState) -> TimerStateStore {
//        return .init(
//            initialState: initialState,
//            reducer: { (_, _, _) in },
//            context: MockTimerFactory.timerViewContext
//        )
//    }
//    
//    static let timerContext: TimerContext = .init(
//        timer: MockTimerFactory.timer,
//        goalStoreWriter: MockGoalFactory.makeGoalReaderAndWriter().writer
//    )
//    
//    static let timerViewContext: TimerViewContext = .init(
//        timerStateStore: MockTimerFactory.timerStateStore(.inactive)
//    )
}

private final class MockTimer: TwentyTimer {
    func resume() {}
    func suspend() {}
}
