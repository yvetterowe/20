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
        let goalID: String
        let goalStoreWriter: GoalStoreWriter
        let goalPublisher: GoalPublisher
        let selectDayStore: SelectDayStore
        let todayPublisher: AnyPublisher<Date.Day, Never>
    }
    
    private let context: Context
    @ObservedObject private var viewStateStore: TimerTabViewStateStore
    @State private var presentingTimer: Bool = false
    
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
            if case .today = viewStateStore.state {
                Button("Start Tracking") {
                    presentingTimer = true
                }.sheet(isPresented: $presentingTimer) {
                    StatefulTimerView(
                        timerStateStore: .init(
                            initialState: .init(isActive: false, elapsedTime: nil),
                            goalStoreWriter: context.goalStoreWriter,
                            goalID: context.goalID
                        ),
                        presentingTimer: $presentingTimer
                    )
                }
            }
            StatefulProgressView(goalPublisher: context.goalPublisher).frame(height: 16)
        }
    }
}

//struct StatefulTimerTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulTimerTabView(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.activeState))
//    }
//}
