//
//  CalendarTests.swift
//  TwentyTests
//
//  Created by Hao Luo on 6/4/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation
import XCTest
@testable import Twenty

class CalendarTests: XCTestCase {

    private let calendar = Calendar.current
    private lazy var today = DateComponents(calendar: calendar, year: 2020, month: 6, day: 4).date!
    
    func testDaysInWeek() {
        let daysInWeek = calendar.daysInWeek(today)
        
        let expectedDaysInWeek: [Date.Day] = [
            DateComponents(calendar: calendar, year: 2020, month: 5, day: 31),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 1),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 2),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 3),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 4),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 5),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 6),
            ].map { $0.date!.asDay(in: calendar)}
        
        XCTAssertEqual(daysInWeek, expectedDaysInWeek)
    }
    
    func testWeeksInMonth() {
        let weeksInMonth = calendar.weeksInMonth(today)
        
        let expectedWeeksInMonth: [Date.Week] = [
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 1),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 7),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 14),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 21),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 28),
        ].map { $0.date!.asWeek(in: calendar)}
        
        XCTAssertEqual(weeksInMonth, expectedWeeksInMonth)
    }
    
    func testMonthsInYear() {
        let monthsInYear = calendar.monthsInYear(today)
        
        let expectedMonthsInYear: [Date.Month] = (1...12)
            .map { DateComponents(calendar: calendar, year: 2020, month: $0, day: 1).date! }
            .map { $0.asMonth(in: calendar) }
        
        XCTAssertEqual(monthsInYear, expectedMonthsInYear)
    }
}
