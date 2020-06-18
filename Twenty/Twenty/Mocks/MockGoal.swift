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
        -> (reader: AnyGoalStoreReader<MockGoalStore>, writer: GoalStoreWriter) {
        let mockGoalStore = MockGoalStore()
        return (AnyGoalStoreReader(mockGoalStore), mockGoalStore)
    }
}

final class MockGoalStore: GoalStoreReader, GoalStoreWriter {
     
    private typealias GoalSubject = CurrentValueSubject<GoalImpl, Never>
    
    private var goalSubjectsByID: [GoalID: GoalSubject]
    
    private let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("mockdb")
    
    init() {
        let mockGoals: [GoalImpl]
        if let jsonData = FileManager.default.contents(atPath: fileURL.path) {
            mockGoals = try! JSONDecoder().decode([GoalImpl].self, from: jsonData)
        } else {
            mockGoals = MockGoalFactory.mockGoals
        }
        
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
        
        saveToFile()
    }
    
    // MARK: - Helpers
    
    private func goalSubject(for goalID: GoalID) -> GoalSubject {
        guard let goalSubject = goalSubjectsByID[goalID] else {
            fatalError("Goal with id \(goalID) doesn't exist!")
        }
        
        return goalSubject
    }
    
    private func saveToFile() {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try? FileManager.default.removeItem(at: fileURL)
        }
        
        let goals = goalSubjectsByID.values.map {$0.value}
        let jsonGoals = try! JSONEncoder().encode(goals)
        try? jsonGoals.write(to: fileURL)
    }
}
