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
    private var cancellable: AnyCancellable!
    
    init(persistentDataStore: PersistentDataStore) {
        self.persistentDataStore = persistentDataStore
        self.goalSubjectsByID = [:]
        self.firstGoalSubject = .init(nil)
        
        self.cancellable = persistentDataStore
            .retrieveAllGoals()
            .sink(receiveCompletion: { completion in
                print(completion)
            }) { [weak self] goals in
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
    
    func appendTrackRecord(_ trackRecord: TrackRecord, forGoal goalID: GoalID) -> AnyPublisher<Void, GoalStoreWriterError> {
        let subject = goalSubject(for: goalID)
        var updatedGoal = subject.value
        updatedGoal.appendTrackRecord(trackRecord)
        subject.send(updatedGoal)
        
        return persistentDataStore
            .updateGoal(for: goalID, with: updatedGoal)
            .mapError { GoalStoreWriterError.persistentStoreError($0) }
            .eraseToAnyPublisher()
    }
    
    func updateGoalName(_ goalName: String, forGoal goalID: GoalID) -> AnyPublisher<Void, GoalStoreWriterError> {
        let subject = goalSubject(for: goalID)
        var updatedGoal = subject.value
        updatedGoal.name = goalName
        subject.send(updatedGoal)
        
        return persistentDataStore
            .updateGoal(for: goalID, with: updatedGoal)
            .mapError { GoalStoreWriterError.persistentStoreError($0) }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Helpers
    
    private func goalSubject(for goalID: GoalID) -> GoalSubject {
        guard let goalSubject = goalSubjectsByID[goalID] else {
            fatalError("Goal with id \(goalID) doesn't exist!")
        }
        
        return goalSubject
    }
}
