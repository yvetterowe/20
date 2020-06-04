//
//  CalendarMonthView.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct CalendarMonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let referenceDate: Date
    let content: (Date) -> DateView

    init(
        referenceDate: Date,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.referenceDate = referenceDate
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(calendar.weeksInMonth(referenceDate), id: \.self) { week in
                CalendarWeekView(referenceDate: week.date, content: self.content)
            }
        }
    }
}

struct CalendarMonthView_Previews: PreviewProvider {
    private static let calendar = Calendar.current
    private static let today = Date()
    static var previews: some View {
        CalendarMonthView(referenceDate: today) { date in
            Text("\(calendar.component(.day, from: date))")
                .frame(width: 40.0, height: 40.0)
        }
    }
}
