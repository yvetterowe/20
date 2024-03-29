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
    let authService: AuthenticationService
}

struct StatefulDayView<TimerView>: View where TimerView: View{
    
    enum ActiveSheet: Identifiable {
        case addTime, editGoal, viewActivities, deleteGoal
        
        var id: Int {
            hashValue
        }
    }
    
    private let context: Context
    private let timerView: (Binding<Bool>) -> TimerView
    @ObservedObject private var viewStateStore: ObservableWrapper<SelectedDayViewState>
    private let dayViewHeaderViewModelStore: DayViewHeaderViewModelStore
    @State private var presentingTimer: Bool = false
    @State private var presentingMoreActionSheet: Bool = false
    @State private var presentingCalendar: Bool = false
    @State private var presentingProfile: Bool = false
    
    @State private var activeSheet: ActiveSheet?
    @State private var editingGoal: Bool = false
    
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
        VStack(alignment: .leading){
            StatefulDayViewHeader(
                viewModelStore: .init(publisher: dayViewHeaderViewModelStore.publisher),
                selectDayWriter: context.selectDayStore,
                presentingCalendar: $presentingCalendar,
                presentingProfile: $presentingProfile,
                authService: context.authService
            )
            
            StatefulSelectDayHeader(
                store: context.selectDayStore
            )
            VStack(alignment: .leading){
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
                Divider()
                StatefulStatisticSectionView(
                    viewReader: .init(
                        publisher: StatisticSectionViewStore(
                            goalPublisher: context.goalPublisher,
                            selectedDayPublisher: context.selectDayStore.selectDayPublisher
                        ).publisher
                    )
                )
                Divider()
                Spacer()
                if viewStateStore.value.isToday {
                    if #available(iOS 14.0, *) {
                        Button("Start Tracking") {
                            presentingTimer = true
                        }
                        .buttonStyle(DarkPrimaryTextButtonStyle())
                        .fullScreenCover(isPresented: $presentingTimer) {
                            self.timerView($presentingTimer)
                        }
                    }
                }
            }.padding(.horizontal, 20)

        }.actionSheet(isPresented: $presentingMoreActionSheet){
            ActionSheet(
                title: Text("Actions"),
                buttons: [
                    .default(Text("Add time"), action : {
                        activeSheet = .addTime
                        editingGoal = true
                    }),
                    .default(Text("Edit goal"), action : { activeSheet = .editGoal }),
                    .default(Text("View activity"), action : { activeSheet = .viewActivities }),
                    .destructive(Text("Delete goal"), action : { activeSheet = .deleteGoal }),
                    .cancel()
                ]
            )
        }.sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
            case .addTime:
                StatefulAddTimeView(viewWriter: NoOpAddTimeViewWriter(), initialDateInterval: .init())
            case .editGoal:
                let viewStore = EditGoalStore(
                    goalPublisher: context.goalPublisher,
                    goalStoreWriter: context.goalStoreWriter,
                    editing: $editingGoal
                )
                StatefulEditGoalView(
                    goalNameReader: .init(publisher: viewStore.goalNamePublisher),
                    viewWriter: viewStore,
                    goalID: context.goalID
                )
            case .viewActivities:
                let viewStore = ViewActivityListViewStore(
                    goalPublisher: context.goalPublisher
                )
                StatefulViewActivityListView(
                    viewReader: .init(publisher: viewStore.publisher)
                )
            case .deleteGoal:
                Text("Delete goal pressed")
            }
        })
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
