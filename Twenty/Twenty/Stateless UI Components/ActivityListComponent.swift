//
//  ActivityListComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ActivityListComponent: View {
    let model: Model
    
    struct Model {
        let sortedRecordsByMonth: [[DateInterval]]
        
        init(records: [DateInterval]) {
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
            
            self.sortedRecordsByMonth = recordsByMonth.keys
                .sorted { $0 < $1 }
                .map { recordsByMonth[$0]!.sorted{ $0.start < $1.start } }
        }
    }
    
    var body: some View {
        List {
            ForEach(model.sortedRecordsByMonth.filter{!$0.isEmpty}, id: \.self) { recordsInMonth in
                Section(header: Text("\(recordsInMonth.first!.start.format(with: "MMM yyyy"))")) {
                    ForEach(recordsInMonth, id: \.self) { record in
                        ActivityRowComponent(recordTime: record)
                    }
                }
            }
        }
    }
}

struct ActivityListComponent_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListComponent(
            model: .init(records: MockDataFactory.recordIntervals.flatMap {$0})
        )
    }
}
