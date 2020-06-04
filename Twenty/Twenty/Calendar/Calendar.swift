//
//  Calendar.swift
//  Twenty
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

extension Date {
    
    struct Day: Equatable {
        let date: Date
        fileprivate init(date: Date) {
            self.date = date
        }
    }
    
    struct Week: Equatable {
        let date: Date
        fileprivate init(date: Date) {
            self.date = date
        }
    }
    
    struct Month: Equatable {
        let date: Date
        fileprivate init(date: Date) {
            self.date = date
        }
    }
    
    func asDay(in calendar: Calendar) -> Day {
        precondition(
            calendar.date(self, matchesComponents: calendar.dayMatchingComponents()),
            "\(self) doesn't satisfy components format for Day"
        )
        return .init(date: self)
    }
    
    func asWeek(in calendar: Calendar) -> Week {
        precondition(
            calendar.date(self, matchesComponents: calendar.weekMatchingComponents()),
            "\(self) doesn't satisfy components format for Week"
        )
        return .init(date: self)
    }
    
    func asMonth(in calendar: Calendar) -> Month {
        precondition(
            calendar.date(self, matchesComponents: calendar.monthMatchingComponents()),
            "\(self) doesn't satisfy components format for Month"
        )
        return .init(date: self)
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
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
        ).map { $0.asWeek(in: self) }
    }
    
    func monthsInYear(_ year: Date) -> [Date.Month] {
        guard let yearInterval = dateInterval(of: .year, for: year) else {
            return []
        }
        
        return dates(
            inside: yearInterval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
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
    
    fileprivate func weekMatchingComponents() -> DateComponents {
        return .init(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
    }
    
    fileprivate func monthMatchingComponents() -> DateComponents {
        .init(day: 1, hour: 0, minute: 0, second: 0)
    }
}
