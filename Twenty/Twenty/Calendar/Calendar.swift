//
//  Calendar.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

extension Calendar {
    
    func daysInWeek(_ week: Date) -> [Date] {
        guard let weekInterval = dateInterval(of: .weekOfYear, for: week) else {
            return []
        }
        
        return dates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    func weeksInMonth(_ month: Date) -> [Date] {
        guard let monthInterval = dateInterval(of: .month, for: month) else {
            return []
        }
        
        return dates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
        )
    }
    
    private func dates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}
