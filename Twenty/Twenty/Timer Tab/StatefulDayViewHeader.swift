//
//  StatefulDayViewHeader.swift
//  Twenty
//
//  Created by Hao Luo on 8/23/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol DayViewHeaderViewModelReader {
    var publisher: AnyPublisher<StatefulDayViewHeader.ViewModel, Never> { get }
}

final class DayViewHeaderViewModelStore: DayViewHeaderViewModelReader {
        
    // MARK: - DayViewHeaderViewModelReader
    
    let publisher: AnyPublisher<StatefulDayViewHeader.ViewModel, Never>
    
    init(selectedDayViewStatePublisher: AnyPublisher<SelectedDayViewState, Never>) {
        self.publisher = selectedDayViewStatePublisher.map { state in
            StatefulDayViewHeader.ViewModel(
                title: state.isToday ? "Today" : state.day.date.weekdayDescription(),
                subtitle: state.day.date.shortDayDescription(),
                selectedDay: state.day
            )
        }.eraseToAnyPublisher()
    }
}

struct StatefulDayViewHeader: View {
    
    struct ViewModel {
        let title: String
        let subtitle: String
        let selectedDay: Date.Day
    }
    
    @ObservedObject private var viewModelStore: ObservableWrapper<StatefulDayViewHeader.ViewModel>
    private let selectDayWriter: SelectDayStoreWriter
    
    // Calendar
    @Binding var presentingCalendar: Bool
    @ObservedObject private var calendarStore: CalendarListViewStore
    
    // Profile
    @Binding var presentingProfile: Bool
    private let profileStore: UserProfileViewStore
    
    private var viewModel: ViewModel {
        return viewModelStore.value
    }
    
    init(
        viewModelStore: ObservableWrapper<StatefulDayViewHeader.ViewModel>,
        selectDayWriter: SelectDayStoreWriter,
        presentingCalendar: Binding<Bool>,
        presentingProfile: Binding<Bool>,
        authService: AuthenticationService
    ) {
        self.viewModelStore = viewModelStore
        self.selectDayWriter = selectDayWriter
        self._presentingCalendar = presentingCalendar
        self.calendarStore = .init(
            initialSelectedDay: viewModelStore.value.selectedDay.date,
            selectDayWriter: selectDayWriter,
            presentingCalendar: presentingCalendar
        )
        self._presentingProfile = presentingProfile
        self.profileStore = .init(authService: authService)
    }
    
    var body: some View {
        HStack {
            DayViewHeaderComponent(
                title: viewModel.title,
                subtitle: viewModel.subtitle
            )
            Spacer()
            Button(action: {
                presentingProfile = true
            }, label: {
                Image(systemName: "person")
            })
            .sheet(isPresented: $presentingProfile) {
                StatefulUserProfileView(store: profileStore)
            }
            
            Button(action: {
                presentingCalendar = true
            }, label: {
                Image(systemName: "calendar")
            })
            .sheet(isPresented: $presentingCalendar) {
                StatefulCalendarListView(selectedDay: $calendarStore.selectedDate)
            }
        }
    }
}

struct StatefulDayViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        StatefulDayViewHeader(
            viewModelStore: .init(
                publisher: Just(
                    .init(
                        title: "Today",
                        subtitle:"Sept 19",
                        selectedDay: Date().asDay(in: .current)
                    )
                ).eraseToAnyPublisher()
            ),
            selectDayWriter: NoOpSelectDayStoreWriter(),
            presentingCalendar: .constant(false),
            presentingProfile: .constant(false),
            authService: NoOpAuthService()
        )
    }
}
