//
//  TimerStateStore.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

final class TimerStateStore: ObservableObject, Subscriber {
    
    @Published private(set) var state: StatefulTimerView.ViewState
    
    init(initialState: StatefulTimerView.ViewState, timer: TwentyTimer) {
        self._state = .init(initialValue: initialState)
        timer.state.subscribe(self)
    }
    // MARK: - Subscriber
    
    typealias Input = TimerState
    typealias Failure = Never
    
    var combineIdentifier: CombineIdentifier {
        return .init()
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: TimerState) -> Subscribers.Demand {
        switch(state, input) {
        case (.inactive, .inactive):
            break
        case (let .active(viewTime), .inactive):
            state = .inactive(viewTime)
        case (_, let .active(timerTime)):
            state = .active(timerTime)
        }
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        self.state = .inactive(state.elapsedTime)
    }
}

import Foundation

struct Goal {
    let name: String
    let records: [Record]
    
    struct Record {
        let startDate: Date
        let endDate: Date
    }
}
