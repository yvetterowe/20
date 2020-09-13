//
//  StatefulDayViewSummarySection.swift
//  Twenty
//
//  Created by Hao Luo on 8/25/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol DayViewSummarySectionViewModelReader {
    var publisher: AnyPublisher<StatefulDayViewSummarySection.ViewModel, Never> { get }
}

final class StatefulDayViewSummarySectionViewModelStore: ObservableObject {
    
    // MARK: - DayViewSummarySectionViewModelReader
    
    let publisher: AnyPublisher<StatefulDayViewSummarySection.ViewModel, Never>
    
    init(
        selectedDayPublisher: AnyPublisher<Date.Day, Never>,
        goalPublisher: AnyPublisher<Goal, Never>
    ) {
        self.publisher = Publishers.CombineLatest(selectedDayPublisher, goalPublisher).map {
            (selectedDay, goal)  in
            return StatefulDayViewSummarySection.ViewModel(
                subtitle: goal.name,
                duration: goal.totalTimeSpent(on: selectedDay)
            )
        }.eraseToAnyPublisher()
    }
}

struct StatefulDayViewSummarySection: View {
    struct ViewModel {
        let subtitle: String
        let duration: TimeInterval
    }
    
    @ObservedObject private var viewModelStore: ObservableWrapper<StatefulDayViewSummarySection.ViewModel>
    private var viewModel: ViewModel {
        return viewModelStore.value
    }
    
    private let tapMoreButtonAction: () -> Void
    
    init(
        viewModelStore: ObservableWrapper<StatefulDayViewSummarySection.ViewModel>,
        tapMoreButtonAction: @escaping () -> Void
    ) {
        self.viewModelStore = viewModelStore
        self.tapMoreButtonAction = tapMoreButtonAction
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            GoalSummarySectionComponent(
                title: viewModel.subtitle,
                buttonAction: tapMoreButtonAction
            )
            TimeLabelComponent(duration: viewModel.duration)
        }
    }
}

struct StatefulDayViewSummarySection_Previews: PreviewProvider {
    static var previews: some View {
        StatefulDayViewSummarySection(
            viewModelStore: .init(publisher: Just(StatefulDayViewSummarySection.ViewModel(subtitle: "", duration: 100)).eraseToAnyPublisher()),
            tapMoreButtonAction: {}
        )
    }
}
