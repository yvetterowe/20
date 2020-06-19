//
//  GoalStoreImpl.swift
//  Twenty
//
//  Created by Hao Luo on 6/17/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

final class GoalStoreImpl: GoalStoreReader, GoalStoreWriter {
     
    private typealias GoalSubject = CurrentValueSubject<GoalImpl, Never>
    
    private let persistentDataStore: PersistentDataStore
    private var goalSubjectsByID: [GoalID: GoalSubject]
    private var firstGoalSubject: CurrentValueSubject<GoalImpl?, Never>
    
    init(persistentDataStore: PersistentDataStore) {
        self.persistentDataStore = persistentDataStore
        self.goalSubjectsByID = [:]
        self.firstGoalSubject = .init(nil)
        
        persistentDataStore.retrieveAllGoals{ [weak self] result in
            switch result {
            case let .success(goals):
                guard let self = self else {
                    return
                }
                
                self.goalSubjectsByID = goals.reduce([:]) { (goalSubjectsByID, goal) -> [GoalID: GoalSubject] in
                    var dict = goalSubjectsByID
                    dict[goal.id] = GoalSubject(goal)
                    return dict
                }
                
                if let firstGoal = goals.first {
                    self.firstGoalSubject.send(firstGoal)
                }
                
            case let .failure(error):
                print(error)
                
            }
        }
    }
    
    // MARK: - GoalStoreReader
    
    func goalPublisher(for goalID: GoalID) -> GoalPublisher {
        return goalSubject(for: goalID).map { $0 as Goal}
            .eraseToAnyPublisher()
    }
    
    var firstGoalPublisher: AnyPublisher<Goal?, Never> {
        return firstGoalSubject
            .map {$0 as Goal?}
            .eraseToAnyPublisher()
    }
    
    // MARK: - GoalStoreWriter
    
    func appendTrackRecord(_ trackRecord: TrackRecord, forGoal goalID: GoalID) {
        let subject = goalSubject(for: goalID)
        var updatedGoal = subject.value
        updatedGoal.appendTrackRecord(trackRecord)
        subject.send(updatedGoal)
        
        persistentDataStore.updateGoal(for: goalID, with: updatedGoal) {_ in }
    }
    
    // MARK: - Helpers
    
    private func goalSubject(for goalID: GoalID) -> GoalSubject {
        guard let goalSubject = goalSubjectsByID[goalID] else {
            fatalError("Goal with id \(goalID) doesn't exist!")
        }
        
        return goalSubject
    }
}
