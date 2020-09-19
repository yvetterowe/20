//
//  GoalTests.swift
//  TwentyTests
//
//  Created by Hao Luo on 9/16/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import XCTest
@testable import Twenty

class GoalTests: XCTestCase {
    
    private let selectedDay: Date.Day = Date(year: 2020, month: 7, day: 14).asDay(in: .current)
    
    func testRemainingTime() {
        XCTAssertEqual(MockDataFactory.goal.remainingTime(asOf: selectedDay), 64800)
    }
    
    func testAvgTimePerDay() {
        XCTAssertEqual(MockDataFactory.goal.avgTimePerDay(asOf: selectedDay), 3600)
    }
    
    func testRecordsCount() {
        XCTAssertEqual(MockDataFactory.goal.recordsCount(asOf: selectedDay), 3)
    }

}
