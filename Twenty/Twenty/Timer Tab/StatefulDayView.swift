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
    let goalName: String
}

protocol DayViewModelReader {
    var publisher: AnyPublisher<SelectedDayViewState, Never> { get }
}

final class DayViewModelStore: DayViewModelReader {
    
    // MARK: - DayViewModelReader
    
    let publisher: AnyPublisher<SelectedDayViewState, Never>
    
    init(
        selectedDayPublisher: AnyPublisher<Date.Day, Never>,
        todayPublisher: AnyPublisher<Date.Day, Never>,
        goalPublisher: AnyPublisher<Goal, Never>
    ) {
        self.publisher = Publishers.CombineLatest3(
            selectedDayPublisher,
            todayPublisher,
            goalPublisher
        ).map { (selectedDay, today, goal) in
            return SelectedDayViewState(
                isToday: selectedDay == today,
                day: selectedDay,
                goalName: goal.name
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
    @State private var presentingMoreActionSheet: Bool = false
    @State private var presentingCalendar: Bool = false
    
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
                viewModelStore: .init(publisher: dayViewHeaderViewModelStore.publisher),
                selectDayWriter: context.selectDayStore,
                presentingCalendar: $presentingCalendar
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
                ), tapMoreButtonAction: {
                    presentingMoreActionSheet = true
                }
            )
            
            StatefulStatisticSectionView(
                viewReader: .init(
                    publisher: StatisticSectionViewStore(
                        goalPublisher: context.goalPublisher,
                        selectedDayPublisher: context.selectDayStore.selectDayPublisher
                    ).publisher
                )
            )
            
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
        }.bottomSheet(
            isOpen: $presentingMoreActionSheet,
            maxHeight: 360,
            title: viewStateStore.value.goalName,
            navigationLeadingItem: {},
            navigationTrailingItem: {}
        ) {
            let viewStore = MoreActionListViewStore(
                goalPublisher: context.goalPublisher
            )
            StatefulMoreActionListView(
                viewReader: .init(publisher: viewStore.titlePublisher),
                viewWriter: viewStore,
                context: context
            )
        }
    }
}

struct StatefulDayView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulDayView(
            context: MockDataFactory.context,
            viewStateStore: ObservableWrapper(
                publisher: Just(SelectedDayViewState(isToday: true, day: MockDataFactory.today, goalName: "Learn surfing")).eraseToAnyPublisher()
            )
        ) { _ in
            Text("Timer Placeholder")
        }
    }
}
