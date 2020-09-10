//
//  NoOpMocks.swift
//  Twenty
//
//  Created by Hao Luo on 9/9/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

final class NoOpGoalWriter: GoalStoreWriter {
    func appendTrackRecord(_ trackRecord: TrackRecord, forGoal goalID: GoalID) -> AnyPublisher<Void, GoalStoreWriterError> {
        fatalError("Not Implemented")
    }
}
