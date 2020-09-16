//
//  StatefulViewActivityListView.swift
//  Twenty
//
//  Created by Hao Luo on 9/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol ViewActivityListViewReader {
    var publisher: AnyPublisher<ActivityListComponent.Model, Never> { get }
}

final class ViewActivityListViewStore: ViewActivityListViewReader {
    
    let publisher: AnyPublisher<ActivityListComponent.Model, Never>
    
    init(goalPublisher: GoalPublisher) {
        self.publisher = goalPublisher.map {
            ActivityListComponent.Model(records: $0.trackRecords.map { $0.timeSpan })
        }.eraseToAnyPublisher()
    }
}

struct StatefulViewActivityListView: View {
    
    @ObservedObject private var viewReader: ObservableWrapper<ActivityListComponent.Model>
    
    init(viewReader: ObservableWrapper<ActivityListComponent.Model>) {
        self.viewReader = viewReader
    }
    
    var body: some View {
        NavigationView {
            ActivityListComponent(
                model: viewReader.value
            )
            .navigationBarTitle("Activities")
        }
    }
}

struct StatefulViewActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulViewActivityListView(
            viewReader: .init(
                publisher: Just(
                    ActivityListComponent.Model(records: MockDataFactory.recordIntervals.flatMap{$0}
                    )
                ).eraseToAnyPublisher()
            )
        )
    }
}
