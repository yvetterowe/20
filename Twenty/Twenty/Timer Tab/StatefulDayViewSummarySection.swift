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
    @Published private(set) var value: StatefulDayViewSummarySection.ViewModel = .init(subtitle: "", title: "")
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
                    title: goal.totalTimeSpent(on: selectedDay).format()
                )
        })
    }
}

struct StatefulDayViewSummarySection: View {
    struct ViewModel {
        let subtitle: String
        let title: String
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
            HStack {
                Text(viewModel.subtitle)
                Spacer()
                Button {
                    print("More tapped")
                } label: {
                    Image(systemName: "ellipsis")
                }

            }
            Text(viewModel.title)
        }
    }
}

//struct StatefulDayViewSummarySection_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulDayViewSummarySection()
//    }
//}