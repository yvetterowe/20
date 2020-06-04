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
    
    func testDaysInWeek() {
        let week = DateComponents(calendar: calendar, year: 2020, month: 6, day: 4).date!
        let daysInWeek = calendar.daysInWeek(week)
        
        let expectedDaysInWeek: [Date] = [
            DateComponents(calendar: calendar, year: 2020, month: 5, day: 31),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 1),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 2),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 3),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 4),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 5),
            DateComponents(calendar: calendar, year: 2020, month: 6, day: 6),
        ].map{$0.date!}
        
        XCTAssertEqual(daysInWeek, expectedDaysInWeek)
    }
}
