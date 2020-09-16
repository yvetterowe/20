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
    var publisher: AnyPublisher<[[DateInterval]], Never> { get }
}

final class ViewActivityListViewStore: ViewActivityListViewReader {
    
    let publisher: AnyPublisher<[[DateInterval]], Never>
    
    init(goalPublisher: GoalPublisher) {
        self.publisher = goalPublisher.map {
            ViewActivityListViewStore.recordsSortedByMonth($0.trackRecords.map {$0.timeSpan})
        }.eraseToAnyPublisher()
    }
    
    private static func recordsSortedByMonth(_ records: [DateInterval]) -> [[DateInterval]] {
        let recordsByMonth: [Date.Month: [DateInterval]] = records.reduce([:]) { (prev, record) in
            var prevRecordsByMonth = prev
            let month = record.start.asMonth(in: .current)
            if prevRecordsByMonth[month] != nil {
                prevRecordsByMonth[month]!.append(record)
            } else {
                prevRecordsByMonth[month] = [record]
            }
            return prevRecordsByMonth
        }
        
        return recordsByMonth.keys
            .sorted { $0 < $1 }
            .map { recordsByMonth[$0]! }
    }
}

struct StatefulViewActivityListView: View {
    
    @ObservedObject private var viewReader: ObservableWrapper<[[DateInterval]]>
    
    init(viewReader: ObservableWrapper<[[DateInterval]]>) {
        self.viewReader = viewReader
    }
    
    var body: some View {
        ActivityListComponent(
            sortedRecords: viewReader.value
        )
    }
}

struct StatefulViewActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulViewActivityListView(
            viewReader: .init(publisher: Just(MockDataFactory.recordIntervals).eraseToAnyPublisher())
        )
    }
}
