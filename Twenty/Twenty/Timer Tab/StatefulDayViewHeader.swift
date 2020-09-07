//
//  StatefulDayViewHeader.swift
//  Twenty
//
//  Created by Hao Luo on 8/23/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

final class DayViewHeaderViewModelStore: ObservableObject {
    @Published private(set) var value: StatefulDayViewHeader.ViewModel = .init(title: "", subtitle: "")
    private var cancellable: AnyCancellable!
    
    init(selectedDayViewState: TimerTabViewStateStore) {
        cancellable = selectedDayViewState.$state.sink { [weak self] state in
            guard let self = self else {
                return
            }
            self.value = .init(
                title: state.isToday ? "Today" : state.day.date.weekdayDescription(),
                subtitle: state.day.date.shortDayDescription()
            )
        }
    }
}

struct StatefulDayViewHeader: View {
    
    struct ViewModel {
        let title: String
        let subtitle: String
    }
    
    @ObservedObject private var viewModelStore: DayViewHeaderViewModelStore
    private var viewModel: ViewModel {
        return viewModelStore.value
    }
    
    init(viewModelStore: DayViewHeaderViewModelStore) {
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
//
//struct StatefulDayViewHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulDayViewHeader()
//    }
//}
