//
//  TimerStateStore.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import Foundation

final class TimerStateStore: ObservableObject, Subscriber {
    
    @Published private(set) var state: StatefulTimerView.ViewState = .loading
    private let currentDate: Date
    
    init(goalPublisher: GoalPublisher, timer: TwentyTimer, currentDate: Date) {
        self.currentDate = currentDate
        Publishers.CombineLatest(goalPublisher, timer.state)
            .map{(goal: $0, timerState: $1)}
            .receive(on: RunLoop.main)
            .subscribe(self)
    }
    // MARK: - Subscriber
    
    typealias Input = (goal: Goal, timerState: TimerState)
    typealias Failure = Never
    
    var combineIdentifier: CombineIdentifier {
        return .init()
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        switch(state, input.timerState) {
        case (.loading, .inactive):
            state = .inactive(input.goal.totalTimeSpent(on: .init(currentDate.stripTime())))
        case (.loading, .active):
            fatalError("Timer shouldn't be active when view is in loading state")
        case (.inactive, .inactive):
            break
        case (_, let .active(timerTime)):
            state = .active(timerTime)
        case (let .active(viewTime), .inactive):
            state = .inactive(viewTime)
        case (.active, .loading):
            fatalError("View shouldn't be active when timer is in loading state")
        case (_, .loading):
            break
        }
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        self.state = .inactive(state.elapsedTime)
    }
}
