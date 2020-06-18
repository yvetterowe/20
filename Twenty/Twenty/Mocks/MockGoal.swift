//
//  Pod.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//
import Combine
import Foundation

enum MockGoalFactory {
    
    static let mockGoals: [GoalImpl] = [
        .init(
            id: "goal-0",
            name: "Learn SwiftUI",
            timeToComplete: 72000,
            trackRecords: [
                .init(
                    start: DateComponents(calendar: .current, year: 2020, month: 5, day: 28, hour: 9).date!,
                    duration: 1800
                ),
                .init(
                    start: DateComponents(calendar: .current, year: 2020, month: 5, day: 30, hour: 9, minute: 45).date!,
                    duration: 600
                ),
            ].map { TrackRecord(timeSpan: $0)}
        )
    ]
    
    static func makeGoalReaderAndWriter(with goals: [GoalImpl] = mockGoals)
        -> (reader: AnyGoalStoreReader<GoalStoreImpl>, writer: GoalStoreWriter) {
            let mockGoalStore = GoalStoreImpl(persistentDataStore: DiskPersistentDataStore())
        return (AnyGoalStoreReader(mockGoalStore), mockGoalStore)
    }
}
