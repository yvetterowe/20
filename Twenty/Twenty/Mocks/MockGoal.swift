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
            trackRecords: []
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
    var trackRecords: [DateInterval]
    
    func totalTimeSpent(on date: StripTimeDate) -> TimeInterval {
        // TODO
        return 100
    }
    
    mutating func appendTrackRecord(_ trackRecord: DateInterval) {
        self.trackRecords.append(trackRecord)
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
    
    func appendTrackRecord(_ trackRecord: DateInterval, forGoal goalID: GoalID) {
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
