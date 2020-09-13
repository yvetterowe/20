//
//  NoOpMocks.swift
//  Twenty
//
//  Created by Hao Luo on 9/9/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

final class NoOpGoalWriter: GoalStoreWriter {
    func appendTrackRecord(_ trackRecord: TrackRecord, forGoal goalID: GoalID) -> AnyPublisher<Void, GoalStoreWriterError> {
        fatalError("Not Implemented")
    }
}

final class NoOpTimerViewWriter: TimerViewModelWriter {
    func send(_ action: TimerViewAction) {}
}

final class NoOpEditTimeViewWriter: EditTimeViewWriter {
    func cancelEditTime() {
        
    }
    
    func saveEditTime(_ newDate: Date) {
        
    }
}
