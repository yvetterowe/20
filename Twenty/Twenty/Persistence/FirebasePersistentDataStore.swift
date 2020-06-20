//
//  FirebasePersistentDataStore.swift
//  Twenty
//
//  Created by Hao Luo on 6/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

private struct FirebaseGoalModel: Codable{
    let id: String
    let userID: String
    let name: String
    let secondsSpent: Int
    let secondsToComplete: Int
    let trackRecords: [TrackRecord]
    
    struct TrackRecord: Codable {
        let id: String
        let startDate: Date
        let endDate: Date
    }
}

final class FirebasePersistentDataStore: PersistentDataStore {
    
    private let userID: String
    private let db: Firestore
    
    private enum Keys {
        static let goalsCollection = "Goals"
        static let goalIDField = "id"
        static let userIDField = "userID"
        static let nameField = "name"
        static let secondsToCompleteField = "secondsToComplete"
        static let trackRecords = "trackRecords"
    }
    
    init(userID: String) {
        self.userID = userID
        self.db = Firestore.firestore()
    }
        
    // MARK: - PersistentDataStore
    
    func retrieveAllGoals() -> AnyPublisher<[GoalImpl], PersistentDataStoreReadError> {
        let db = self.db, userID = self.userID
        return Future<[GoalImpl], PersistentDataStoreReadError> { promise in
            db.collection(Keys.goalsCollection)
            .whereField(Keys.userIDField, isEqualTo: userID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    return promise(.failure(.fetchError(error)))
                } else {
                    let goals = querySnapshot?.documents
                        .compactMap { try? $0.data(as: FirebaseGoalModel.self) }
                        .map {
                            GoalImpl(
                                id: $0.id,
                                name: $0.name,
                                timeToComplete: TimeInterval($0.secondsToComplete),
                                trackRecords: $0.trackRecords.map { TrackRecord(id: $0.id, timeSpan: .init(start: $0.startDate, end: $0.endDate)) }
                            )
                    } ?? []
                    return promise(.success(goals))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addGoal(_ goal: GoalImpl) -> AnyPublisher<Void, PersistentDataStoreWriteError> {
        let firebaseGoal = FirebaseGoalModel(
            id: goal.id,
            userID: userID,
            name: goal.name,
            secondsSpent: Int(goal.totalTimeSpent),
            secondsToComplete: Int(goal.timeToComplete),
            trackRecords: goal.trackRecords.map { FirebaseGoalModel.TrackRecord(id: $0.id, startDate: $0.timeSpan.start, endDate: $0.timeSpan.end) }
        )
        
        let db = self.db
        return Future<Void, PersistentDataStoreWriteError> { promise in
            let goalRef = db.collection(Keys.goalsCollection).document(goal.id)
                
            do {
                try goalRef.setData(from: firebaseGoal, encoder: Firestore.Encoder()) { error in
                    if let error = error {
                        return promise(.failure(.writeError(error)))
                    }
                    return promise(.success(()))
                }
            } catch {
                return promise(.failure(.encodeError(error)))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateGoal(for goalID: GoalID, with goal: GoalImpl) -> AnyPublisher<Void, PersistentDataStoreWriteError> {
        // TODO: only update track record instead of the whole goal
        return addGoal(goal)
    }
}
