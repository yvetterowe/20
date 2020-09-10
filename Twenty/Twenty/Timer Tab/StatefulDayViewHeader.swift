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
    
    init(selectedDayViewState: TimerTabViewStateStore) {
        self.publisher = selectedDayViewState.$state.map { state in
            StatefulDayViewHeader.ViewModel(
                title: state.isToday ? "Today" : state.day.date.weekdayDescription(),
                subtitle: state.day.date.shortDayDescription()
            )
        }.eraseToAnyPublisher()
    }
}

struct StatefulDayViewHeader: View {
    
    struct ViewModel {
        let title: String
        let subtitle: String
    }
    
    @ObservedObject private var viewModelStore: ObservableWrapper<StatefulDayViewHeader.ViewModel>
    private var viewModel: ViewModel {
        return viewModelStore.value
    }
    
    init(viewModelStore: ObservableWrapper<StatefulDayViewHeader.ViewModel>) {
        self.viewModelStore = viewModelStore
    }
    
    var body: some View {
        HStack {
            DayViewHeaderComponent(
                title: viewModel.title,
                subtitle: viewModel.subtitle
            )
            Spacer()
            Image(systemName: "person")
            Image(systemName: "calendar")
        }
    }
}

struct StatefulDayViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        StatefulDayViewHeader(
            viewModelStore: .init(
                publisher: Just(.init(title: "", subtitle:"")).eraseToAnyPublisher()
            )
        )
    }
}
