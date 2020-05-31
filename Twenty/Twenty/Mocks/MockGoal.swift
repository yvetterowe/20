//
//  Pod.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

final class MockGoalStoreReader: GoalStoreReader {
    
    private typealias GoalSubject = CurrentValueSubject<Goal, Never>
    
    private static let mockGoals: [Goal] = [
        .init(
            id: "goal-0",
            name: "Learn SwiftUI",
            timeToComplete: 72000,
            trackRecords: []
        )
    ]
    
    private static let goalSubjectsByID: [Goal.ID: GoalSubject] = MockGoalStoreReader.mockGoals.reduce([:]) { (goalSubjectsByID, goal) -> [Goal.ID: GoalSubject] in
        var dict = goalSubjectsByID
        dict[goal.id] = GoalSubject(goal)
        return dict
    }
    
    // MARK: - GoalStoreReader
    
    func goalPublisher(for goalID: Goal.ID) -> GoalPublisher {
        guard let goalSubject = MockGoalStoreReader.goalSubjectsByID[goalID] else {
            fatalError("Goal with id \(goalID) doesn't exist!")
        }
        
        return goalSubject.eraseToAnyPublisher()
    }
}
