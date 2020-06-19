//
//  PersistentDataStore.swift
//  Twenty
//
//  Created by Hao Luo on 6/17/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

enum PersistentDataStoreError: Error {
    case createError(Error)
    case readError(Error)
    case updateError(Error)
}

protocol PersistentDataStore {
    func retrieveAllGoals(completion: @escaping (Result<[GoalImpl], PersistentDataStoreError>)->Void)
    func addGoal(_ goal: GoalImpl, completion: @escaping (PersistentDataStoreError?) -> Void)
    func updateGoal(for goalID: GoalID, with goal: GoalImpl, completion: @escaping (PersistentDataStoreError?) -> Void)
}
