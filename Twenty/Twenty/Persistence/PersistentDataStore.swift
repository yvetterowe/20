//
//  PersistentDataStore.swift
//  Twenty
//
//  Created by Hao Luo on 6/17/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

enum PersistentDataStoreError: Error {
}

protocol PersistentDataStore {
    func retrieveAllGoals(forUser userID: String, completion: (Result<[GoalImpl], PersistentDataStoreError>)->Void)
    func addGoal(_ goal: GoalImpl, completion: (PersistentDataStoreError?) -> Void)
    func updateGoal(for goalID: GoalID, with goal: GoalImpl, completion: (PersistentDataStoreError?) -> Void)
}
