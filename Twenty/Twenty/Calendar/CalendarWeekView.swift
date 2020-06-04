//
//  CalendarWeekView.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct CalendarWeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let referenceDate: Date
    let content: (Date) -> DateView

    init(referenceDate: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.referenceDate = referenceDate
        self.content = content
    }

    var body: some View {
        HStack {
            ForEach(calendar.daysInWeek(referenceDate), id: \.self) { day in
                HStack {
                    if self.calendar.isDate(self.referenceDate, equalTo: day.date, toGranularity: .month) {
                        self.content(day.date)
                    } else {
                        self.content(day.date).hidden()
                    }
                }
            }
        }
    }
}

struct CalendarWeekView_Previews: PreviewProvider {
    private static let calendar = Calendar.current
    private static let today = Date()
    static var previews: some View {
        VStack {
            Text("\(today)")
            CalendarWeekView(referenceDate: today) { date in
                return VStack {
                    Text("\(calendar.component(.weekday, from: date))")
                    Text("\(calendar.component(.day, from: date))")
                }.border(.some(color: .black, width: 1, cornerRadius: 0))
            }.border(.some(color: .red, width: 1, cornerRadius: 0))
        }
    }
}
