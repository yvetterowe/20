//
//  PersistentDataStore.swift
//  Twenty
//
//  Created by Hao Luo on 6/17/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

enum PersistentDataStoreError: Error {
    case createError(Error)
    case readError(Error)
    case updateError(Error)
}

enum PersistentDataStoreReadError: Error {
    case fetchError(Error)
}

enum PersistentDataStoreWriteError: Error {
    case encodeError(Error)
    case writeError(Error)
}

protocol PersistentDataStore {
    func retrieveAllGoals() -> AnyPublisher<[GoalImpl], PersistentDataStoreReadError>
    func addGoal(_ goal: GoalImpl) -> AnyPublisher<Void, PersistentDataStoreWriteError>
    func updateGoal(for goalID: GoalID, with goal: GoalImpl) -> AnyPublisher<Void, PersistentDataStoreWriteError>
}
