//
//  StatefulTimerTabView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct SelectedDayViewState {
    let isToday: Bool
    let day: Date.Day
}

final class TimerTabViewStateStore: ObservableObject, Subscriber {
    
    @Published private(set) var state: SelectedDayViewState = .init(isToday: true, day: Date().asDay(in: .current))
        
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
        state = .init(
            isToday: input.selectedDay == input.today,
            day: input.selectedDay
        )
        
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
            StatefulDayViewHeader(
                viewModelStore: .init(selectedDayViewState: viewStateStore)
            )
            StatefulSelectDayHeader(
                store: context.selectDayStore
            )
            StatefulDayViewSummarySection(
                viewModelStore: .init(
                    selectedDayPublisher: context.selectDayStore.selectDayPublisher,
                    goalPublisher: context.goalPublisher
                )
            )
            if #available(iOS 14.0, *) {
                StatisticSectionComponent(
                    items: Array(
                        repeating: .init(
                            icon: .init(systemName: "number.square"),
                            title: "1h 3m",
                            subtitle: "subtitle"
                        ),
                        count: 4
                    ),
                    rowCount: 2
                )
            }
            if viewStateStore.state.isToday {
                if #available(iOS 14.0, *) {
                    Button("Start Tracking") {
                        presentingTimer = true
                    }
                    .fullScreenCover(isPresented: $presentingTimer) {
                        StatefulTimerView(
                            viewStateStore: .init(
                                timerStateStore: .init(
                                    initialState: .init(isActive: false, elapsedTime: nil)
                                ),
                                goalStoreWriter: context.goalStoreWriter,
                                goalID: context.goalID
                            ),
                            presentingTimer: $presentingTimer
                        )
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

//struct StatefulTimerTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulTimerTabView(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.activeState))
//    }
//}
