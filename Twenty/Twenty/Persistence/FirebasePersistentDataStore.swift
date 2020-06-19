//
//  FirebasePersistentDataStore.swift
//  Twenty
//
//  Created by Hao Luo on 6/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

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
    
    func retrieveAllGoals(completion: @escaping (Result<[GoalImpl], PersistentDataStoreError>)->Void) {
        db.collection(Keys.goalsCollection)
            .whereField(Keys.userIDField, isEqualTo: userID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(.failure(.readError(error)))
                } else {
                    let goals =
                    querySnapshot?.documents
                        .compactMap { try? $0.data(as: FirebaseGoalModel.self) }
                        .map {
                            GoalImpl(
                                id: $0.id,
                                name: $0.name,
                                timeToComplete: TimeInterval($0.secondsToComplete),
                                trackRecords: $0.trackRecords.map { TrackRecord(id: $0.id, timeSpan: .init(start: $0.startDate, end: $0.endDate)) }
                            )
                    } ?? []
                    completion(.success(goals))
                }
            }
    }
    
    func addGoal(_ goal: GoalImpl, completion: (PersistentDataStoreError?) -> Void) {
        
    }
    
    func updateGoal(for goalID: GoalID, with goal: GoalImpl, completion: (PersistentDataStoreError?) -> Void) {
        // TODO
    }
}
