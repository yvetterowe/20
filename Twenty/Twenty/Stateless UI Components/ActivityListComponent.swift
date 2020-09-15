//
//  ActivityListComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/14/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct ActivityListComponent: View {
    let sortedRecords: [[DateInterval]] // by month
    
    var body: some View {
        List {
            ForEach(sortedRecords.filter{!$0.isEmpty}, id: \.self) { recordsInMonth in
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
            sortedRecords: [
                [
                    .init(start: .init(year: 2020, month: 6, day: 30), duration: 1800)
                ],
                [
                    .init(start: .init(year: 2020, month: 7, day: 2), duration: 3640),
                    .init(start: .init(year: 2020, month: 7, day: 31), duration: 1800)
                ],
                [
                    .init(start: .init(year: 2020, month: 9, day: 14), duration: 7200)
                ],
            ]
        )
    }
}
