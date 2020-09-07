//
//  StatefulDayViewSummarySection.swift
//  Twenty
//
//  Created by Hao Luo on 8/25/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

final class StatefulDayViewSummarySectionViewModelStore: ObservableObject {
    @Published private(set) var value: StatefulDayViewSummarySection.ViewModel = .init(subtitle: "", duration: 0)
    private var cancellable: AnyCancellable!
    
    init(
        selectedDayPublisher: AnyPublisher<Date.Day, Never>,
        goalPublisher: AnyPublisher<Goal, Never>
    ) {
        cancellable = Publishers.CombineLatest(selectedDayPublisher, goalPublisher)
            .sink(receiveValue: { [weak self] (selectedDay, goal)  in
                guard let self = self else {
                    return
                }
                
                self.value = .init(
                    subtitle: goal.name,
                    duration: goal.totalTimeSpent(on: selectedDay)
                )
        })
    }
}

struct StatefulDayViewSummarySection: View {
    struct ViewModel {
        let subtitle: String
        let duration: TimeInterval
    }
    
    @ObservedObject private var viewModelStore: StatefulDayViewSummarySectionViewModelStore
    private var viewModel: ViewModel {
        return viewModelStore.value
    }
    
    init(viewModelStore: StatefulDayViewSummarySectionViewModelStore) {
        self.viewModelStore = viewModelStore
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            GoalSummarySectionComponent(title: viewModel.subtitle) {
                print("More tapped")
            }
            TimeLabelComponent(duration: viewModel.duration)
        }
    }
}

//struct StatefulDayViewSummarySection_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulDayViewSummarySection()
//    }
//}
