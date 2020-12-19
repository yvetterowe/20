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
    
    func updateGoalName(_ goalName: String, forGoal goalID: GoalID) -> AnyPublisher<Void, GoalStoreWriterError> {
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

final class NoOpMoreActionListViewWriter: MoreActionListViewWriter {
    func send(_ action: MoreActionListViewAction) {
    }
}

final class NoOpEditGoalViewWriter: EditGoalViewWriter{
    func cancelEditGoal() {}
    func saveEditGoalName(_ newGoalName: String, forGoal goalID: GoalID) {}
}

final class NoOpCalendarListViewWriter: CalendarListViewWriter {
    func didSelectDay(_ day: Date) {
        
    }
    
    func didCancel() {
        
    }
}

final class NoOpSelectDayStoreWriter: SelectDayStoreWriter {
    func updateSelectDate(_ date: Date) {
    }
}

final class NoOpAuthService: AuthenticationService {
    func signUp(email: String, password: String, firstName: String?, lastName: String?) {}
    func signIn(email: String, password: String) {}
    func signOut() {}
}

final class NoOpAddTimeViewWriter: AddTimeViewWriter {
    func cancel() {}
    func save(_ newRecord: TrackRecord) {}
}
