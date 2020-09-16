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
        timeToComplete: 1000,
        trackRecords: []
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
