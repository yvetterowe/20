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
    
    static let mockGoals: [MockGoal] = [
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
    
    static func makeGoalReaderAndWriter(with goals: [MockGoal] = mockGoals)
        -> (reader: AnyGoalStoreReader<MockGoalStore>, writer: GoalStoreWriter) {
        let mockGoalStore = MockGoalStore(mockGoals: goals)
        return (AnyGoalStoreReader(mockGoalStore), mockGoalStore)
    }
}

struct MockGoal: Goal, Identifiable {
    let id: GoalID
    let name: String
    let timeToComplete: TimeInterval
    
    private(set) var trackRecords: [TrackRecord]
    private var timeSpentByTimeStripDate: [StripTimeDate: TimeInterval]
    
    init(id: GoalID, name: String, timeToComplete: TimeInterval, trackRecords: [TrackRecord]) {
        self.id = id
        self.name = name
        self.timeToComplete = timeToComplete
        self.trackRecords = []
        self.timeSpentByTimeStripDate = [:]
        
        trackRecords.forEach {
            self.appendTrackRecord($0)
        }
    }
    
    func totalTimeSpent(on date: StripTimeDate) -> TimeInterval {
        return timeSpentByTimeStripDate[date] ?? 0
    }
    
    mutating func appendTrackRecord(_ trackRecord: TrackRecord) {
        print("Track record added! \(trackRecord)")
        trackRecords.append(trackRecord)
        
        // TODO(#13): handle `trackRecord` spreads across multiple days
        let stripTimeDate = StripTimeDate(trackRecord.timeSpan.start.stripTime())
        timeSpentByTimeStripDate[stripTimeDate] = (timeSpentByTimeStripDate[stripTimeDate] ?? 0) + trackRecord.timeSpan.duration
    }
}

final class MockGoalStore: GoalStoreReader, GoalStoreWriter {
     
    private typealias GoalSubject = CurrentValueSubject<MockGoal, Never>
    
    private var goalSubjectsByID: [GoalID: GoalSubject]
    
    init(mockGoals: [MockGoal]) {
        self.goalSubjectsByID = mockGoals.reduce([:]) { (goalSubjectsByID, goal) -> [GoalID: GoalSubject] in
            var dict = goalSubjectsByID
            dict[goal.id] = GoalSubject(goal)
            return dict
        }
    }
    
    // MARK: - GoalStoreReader
    
    func goalPublisher(for goalID: GoalID) -> GoalPublisher {
        return goalSubject(for: goalID).map { $0 as Goal}
            .eraseToAnyPublisher()
    }
    
    // MARK: - GoalStoreWriter
    
    func appendTrackRecord(_ trackRecord: TrackRecord, forGoal goalID: GoalID) {
        let subject = goalSubject(for: goalID)
        var updatedGoal = subject.value
        updatedGoal.appendTrackRecord(trackRecord)
        subject.send(updatedGoal)
    }
    
    // MARK: - Helpers
    
    private func goalSubject(for goalID: GoalID) -> GoalSubject {
        guard let goalSubject = goalSubjectsByID[goalID] else {
            fatalError("Goal with id \(goalID) doesn't exist!")
        }
        
        return goalSubject
    }
}
