//
//  Calendar.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

extension Date {
    
    struct Day: Hashable, Codable {
        let date: Date
        fileprivate init(date: Date) {
            self.date = date
        }
    }
    
    struct Week: Hashable {
        let date: Date
        fileprivate init(date: Date) {
            self.date = date
        }
    }
    
    struct Month: Hashable {
        let date: Date
        fileprivate init(date: Date) {
            self.date = date
        }
    }
    
    func asDay(in calendar: Calendar) -> Day {
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        let stripTimeDate = calendar.date(from: components)!
        return .init(date: stripTimeDate)
    }
    
    func asWeek(in calendar: Calendar) -> Week {
        precondition(
            calendar.date(self, matchesComponents: calendar.weekMatchingComponents(matchWeekday: false)),
            "\(self) doesn't satisfy components format for Week"
        )
        return .init(date: self)
    }
    
    func asMonth(in calendar: Calendar) -> Month {
        let components = calendar.dateComponents([.year, .month], from: self)
        let stripDayDate = calendar.date(from: components)!
        return .init(date: stripDayDate)
    }
    
    func weekdayDescription() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func shortDayDescription() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: self)
    }
}

extension Date.Month: Comparable {
    static func < (lhs: Date.Month, rhs: Date.Month) -> Bool {
        return lhs.date < rhs.date
    }
}

extension Calendar {
    
    func daysInWeek(_ week: Date) -> [Date.Day] {
        guard let weekInterval = dateInterval(of: .weekOfYear, for: week) else {
            return []
        }
        
        return dates(
            inside: weekInterval,
            matching: dayMatchingComponents()
        ).map { $0.asDay(in: self) }
    }
    
    func weeksInMonth(_ month: Date) -> [Date.Week] {
        guard let monthInterval = dateInterval(of: .month, for: month) else {
            return []
        }
        
        return dates(
            inside: monthInterval,
            matching: weekMatchingComponents(matchWeekday: true)
        ).map { $0.asWeek(in: self) }
    }
    
    func monthsInYear(_ year: Date) -> [Date.Month] {
        guard let yearInterval = dateInterval(of: .year, for: year) else {
            return []
        }
        
        return dates(
            inside: yearInterval,
            matching: monthMatchingComponents()
        ).map { $0.asMonth(in: self) }
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
    
    fileprivate func dayMatchingComponents() -> DateComponents {
        return .init(hour: 0, minute: 0, second: 0)
    }
    
    fileprivate func weekMatchingComponents(matchWeekday: Bool) -> DateComponents {
        if matchWeekday {
            return .init(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
        } else {
            return .init(hour: 0, minute: 0, second: 0)
        }
    }
    
    fileprivate func monthMatchingComponents() -> DateComponents {
        .init(day: 1, hour: 0, minute: 0, second: 0)
    }
}
