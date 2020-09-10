//
//  StatefulDayView.swift
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

protocol DayViewModelReader {
    var publisher: AnyPublisher<SelectedDayViewState, Never> { get }
}

final class DayViewModelStore: DayViewModelReader {
    
    // MARK: - DayViewModelReader
    
    let publisher: AnyPublisher<SelectedDayViewState, Never>
    
    init(
        selectedDayPublisher: AnyPublisher<Date.Day, Never>,
        todayPublisher: AnyPublisher<Date.Day, Never>
    ) {
        self.publisher = Publishers.CombineLatest(
            selectedDayPublisher,
            todayPublisher
        ).map { (selectedDay, today) in
            return SelectedDayViewState(
                isToday: selectedDay == today,
                day: selectedDay
            )
        }.eraseToAnyPublisher()
    }
}


struct Context {
    let goalID: String
    let goalStoreWriter: GoalStoreWriter
    let goalPublisher: GoalPublisher
    let selectDayStore: SelectDayStore
    let todayPublisher: AnyPublisher<Date.Day, Never>
}

struct StatefulDayView<TimerView>: View where TimerView: View{
    
    private let context: Context
    private let timerView: (Binding<Bool>) -> TimerView
    @ObservedObject private var viewStateStore: ObservableWrapper<SelectedDayViewState>
    private let dayViewHeaderViewModelStore: DayViewHeaderViewModelStore
    @State private var presentingTimer: Bool = false
    
    init(
        context: Context,
        viewStateStore: ObservableWrapper<SelectedDayViewState>,
        @ViewBuilder timerView: @escaping (Binding<Bool>) -> TimerView
    ) {
        self.context = context
        self.viewStateStore = viewStateStore
        self.timerView = timerView
        self.dayViewHeaderViewModelStore = .init(selectedDayViewStatePublisher: viewStateStore.$value.compactMap{$0}.eraseToAnyPublisher())
    }
    
    var body: some View {
        VStack {
            StatefulDayViewHeader(
                viewModelStore: .init(publisher: dayViewHeaderViewModelStore.publisher)
            )
            StatefulSelectDayHeader(
                store: context.selectDayStore
            )
            StatefulDayViewSummarySection(
                viewModelStore: .init(
                    publisher: StatefulDayViewSummarySectionViewModelStore(
                        selectedDayPublisher: context.selectDayStore.selectDayPublisher,
                        goalPublisher: context.goalPublisher
                    ).publisher
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
            if viewStateStore.value.isToday {
                if #available(iOS 14.0, *) {
                    Button("Start Tracking") {
                        presentingTimer = true
                    }
                    .fullScreenCover(isPresented: $presentingTimer) {
                        self.timerView($presentingTimer)
                    }
                }
            }
        }
    }
}

struct StatefulDayView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulDayView(
            context: Context(
                goalID: "",
                goalStoreWriter: NoOpGoalWriter(),
                goalPublisher: Just(MockDataFactory.goal).eraseToAnyPublisher(),
                selectDayStore: SelectDayStore(initialSelectDay: MockDataFactory.today),
                todayPublisher: Just(MockDataFactory.today).eraseToAnyPublisher()
            ),
            viewStateStore: ObservableWrapper(
                publisher: Just(SelectedDayViewState(isToday: true, day: MockDataFactory.today)).eraseToAnyPublisher()
            )
        ) { _ in
            Text("Timer Placeholder")
        }
    }
}