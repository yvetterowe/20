//
//  StatefulTimerTabView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

enum TimerTabViewState: Equatable {
    case today
    case notToday
}

final class TimerTabViewStateStore: ObservableObject, Subscriber {
    
    @Published private(set) var state: TimerTabViewState = .today
        
    init(
        selectedDayPublisher: AnyPublisher<Date.Day, Never>,
        todayPublisher: AnyPublisher<Date.Day, Never>
    ) {
        Publishers.CombineLatest(
            selectedDayPublisher,
            todayPublisher
        ).map {
            (selectedDay: $0.0, today: $0.1)
        }.subscribe(self)
    }
    
    // MARK: - Subscriber
    
    typealias Input = (selectedDay: Date.Day, today: Date.Day)
    typealias Failure = Never
    
    func receive(_ input: Input) -> Subscribers.Demand {
        state = input.selectedDay == input.today ? .today : .notToday
        
        return .unlimited
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        
    }
}


struct StatefulTimerTabView: View {
    
    struct Context {
        let timerStateStore: TimerStateStore
        let goalPublisher: GoalPublisher
        let timer: TwentyTimer
        let selectDayStore: SelectDayStore
        let todayPublisher: AnyPublisher<Date.Day, Never>
    }
    
    private let context: Context
    @ObservedObject private var viewStateStore: TimerTabViewStateStore
    
    init(context: Context) {
        self.context = context
        self.viewStateStore = .init(
            selectedDayPublisher: context.selectDayStore.selectDayPublisher,
            todayPublisher: context.todayPublisher
        )
    }
    
    var body: some View {
        VStack {
            StatefulSelectDayHeader(store: context.selectDayStore)
            StatefulTimerWatchView(context: context)
            if viewStateStore.state == .today {
                StatefulTimerButton(context: context)
            } else {
                StatefulTimerButton(context: context).hidden()
            }
        }
    }
}

//struct StatefulTimerTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulTimerTabView(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.activeState))
//    }
//}
