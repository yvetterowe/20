//
//  DiskPersistentDataStore.swift
//  Twenty
//
//  Created by Hao Luo on 6/17/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

/// Only used for local testing
final class DiskPersistentDataStore: PersistentDataStore {
    
    private let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("mockdb")
    
    // MARK: - PersistentDataStore
    
    func retrieveAllGoals(completion: (Result<[GoalImpl], PersistentDataStoreError>)->Void) {
        let mockGoals: [GoalImpl]
        if let jsonData = FileManager.default.contents(atPath: fileURL.path) {
            mockGoals = try! JSONDecoder().decode([GoalImpl].self, from: jsonData)
        } else {
            mockGoals = MockGoalFactory.mockGoals
        }
        completion(.success(mockGoals))
    }
    
    func addGoal(_ goal: GoalImpl, completion: (PersistentDataStoreError?) -> Void) {
        
    }
    
    func updateGoal(for goalID: GoalID, with goal: GoalImpl, completion: (PersistentDataStoreError?) -> Void) {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try? FileManager.default.removeItem(at: fileURL)
        }
        
        let jsonGoals = try! JSONEncoder().encode([goal])
        try? jsonGoals.write(to: fileURL)
    }
}
