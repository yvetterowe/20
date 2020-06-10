//
//  StatefulTimerWatchView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

enum TimerWatchViewState {
    case noTimeSpent
    case someTimeSpent(TimeInterval)
}

final class TimerWatchViewStateStore: ObservableObject, Subscriber {
    
    @Published private(set) var state: TimerWatchViewState = .noTimeSpent
        
    init(
        selectedDayPublisher: AnyPublisher<Date.Day, Never>,
        todayPublisher: AnyPublisher<Date.Day, Never>,
        goalPublisher: AnyPublisher<Goal, Never>,
        timerStatePublisher: AnyPublisher<TimerState, Never>
    ) {
        
        Publishers.CombineLatest4(
            selectedDayPublisher,
            todayPublisher,
            goalPublisher,
            timerStatePublisher
        ).map {
            (selectedDay: $0.0, today: $0.1, goal: $0.2, timerState: $0.3)
        }.subscribe(self)
    }
    
    // MARK: - Subscriber
    
    typealias Input = (selectedDay: Date.Day, today: Date.Day, goal: Goal, timerState: TimerState)
    typealias Failure = Never
    
    func receive(_ input: Input) -> Subscribers.Demand {
        var timeSpentOnSelectDay = input.goal.totalTimeSpent(on: .init(input.selectedDay.date.stripTime()))
        if input.selectedDay == input.today {
            timeSpentOnSelectDay += input.timerState.totalElapsedTime
        }
        
        self.state = timeSpentOnSelectDay == 0 ? .noTimeSpent : .someTimeSpent(timeSpentOnSelectDay)
        
        return .unlimited
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        
    }
}

extension StatefulTimerWatchView {
    
    init(timerStateStore: TimerStateStore, goalPublisher: GoalPublisher) {
        let viewStateStore: TimerWatchViewStateStore = .init(
            selectedDayPublisher: Just(MockTimerFactory.currentDate.asDay(in: .current)).eraseToAnyPublisher(),
            todayPublisher: Just(MockTimerFactory.currentDate.asDay(in: .current)).eraseToAnyPublisher(),
            goalPublisher: goalPublisher,
            timerStatePublisher: timerStateStore.timerStatePublisher
        )
        
        self.init(viewStateStore: viewStateStore)
    }
}

struct StatefulTimerWatchView: View {
    
    @ObservedObject private var viewStateStore: TimerWatchViewStateStore
    
    init(viewStateStore: TimerWatchViewStateStore) {
        self.viewStateStore = viewStateStore
    }
    
    var body: some View {
        switch viewStateStore.state {
        case .noTimeSpent:
            return TimerWatchView(
                model: .init(
                    textModel: .init(
                        text: TimeInterval(0).format(),
                        textColor: SementicColorPalette.defaultTextColor,
                        textFont: .title
                    ),
                    radius: 86,
                    backgroundColorMode: .single(.gray)
                )
            )
            
        case let .someTimeSpent(timeInterval):
            return TimerWatchView(
                model: .init(
                    textModel: .init(
                        text: timeInterval.format(),
                        textColor: SementicColorPalette.defaultTextColor,
                        textFont: .title
                    ),
                    radius: 125,
                    backgroundColorMode: .gradient(SementicColorPalette.timerGradient)
                )
            )
        }
    }
}

extension TimeInterval {
    func format() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

//struct StatefulTimerWatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            StatefulTimerWatchView(TimerStateStore: MockTimerFactory.TimerStateStore(.loading))
//            StatefulTimerWatchView(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.activeState))
//            StatefulTimerWatchView(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.inactiveState))
//        }
//    }
//}
