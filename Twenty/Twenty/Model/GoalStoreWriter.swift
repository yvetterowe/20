//
//  GoalStoreWriter.swift
//  Twenty
//
//  Created by Hao Luo on 5/31/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

enum GoalStoreWriterError: Error {
    case persistentStoreError(Error)
}

protocol GoalStoreWriter {
    func appendTrackRecord(_ trackRecord: TrackRecord, forGoal goalID: GoalID) -> AnyPublisher<Void, GoalStoreWriterError>
    func updateGoalName(_ goalName: String, forGoal goalID: GoalID) -> AnyPublisher<Void, GoalStoreWriterError>
}
