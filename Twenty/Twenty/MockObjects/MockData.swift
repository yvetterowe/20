//
//  MockGoal.swift
//  Twenty
//
//  Created by Hao Luo on 9/9/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

enum MockDataFactory {
    
    static let goal: GoalImpl = .init(
        id: "goal-id",
        name: "Learn SwiftUI",
        timeToComplete: 72000,
        trackRecords: [
            .init(id: "record0", timeSpan: .init(start: .init(year: 2020, month: 6, day: 30, hour: 3, minute: 0, second: 0), duration: 1800)),
            .init(id: "record0", timeSpan: .init(start: .init(year: 2020, month: 6, day: 30, hour: 8, minute: 0, second: 0), duration: 3600)), // 2020-06-30, total: 1.5h
            .init(id: "record1", timeSpan: .init(start: .init(year: 2020, month: 7, day: 13), duration: 1800)), // 2020-07-13, total: 0.5h
        ]
    )
    
    static let today: Date.Day = Date().asDay(in: .current)
    
    static let context: Context = .init(
        goalID: "goal-id",
        goalStoreWriter: NoOpGoalWriter(),
        goalPublisher: Just(MockDataFactory.goal).eraseToAnyPublisher(),
        selectDayStore: SelectDayStore(initialSelectDay: MockDataFactory.today),
        todayPublisher: Just(MockDataFactory.today).eraseToAnyPublisher()
    )
    
    static let recordIntervals: [[DateInterval]] =  [
        [
            .init(start: .init(year: 2020, month: 6, day: 30), duration: 1800)
        ],
        [
            .init(start: .init(year: 2020, month: 7, day: 2), duration: 3640),
            .init(start: .init(year: 2020, month: 7, day: 31), duration: 1800)
        ],
        [
            .init(start: .init(year: 2020, month: 9, day: 14), duration: 7200)
        ],
    ]
}
