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
    
    func testRemainingTime() {
        XCTAssertEqual(MockDataFactory.goal.remainingTime, 64800)
    }
    
    func testAvgTimePerDay() {
        XCTAssertEqual(MockDataFactory.goal.avgTimePerDay, 3600)
    }
    
    func testRecordsCount() {
        XCTAssertEqual(MockDataFactory.goal.recordsCount, 3)
    }

}
