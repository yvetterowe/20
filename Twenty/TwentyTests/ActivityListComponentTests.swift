//
//  ActivityListComponentTests.swift
//  TwentyTests
//
//  Created by Hao Luo on 9/15/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import XCTest
@testable import Twenty

class ActivityListComponentTests: XCTestCase {

    func testModel() throws {
        let mayRecord1 = DateInterval(start: .init(year: 2020, month: 5, day: 30), duration: 1800)
        let juneRecord1 = DateInterval(start: .init(year: 2020, month: 6, day: 12), duration: 1800)
        let juneRecord2 = DateInterval(start: .init(year: 2020, month: 6, day: 28), duration: 3600)
        let julyRecord1 = DateInterval(start: .init(year: 2020, month: 7, day: 2), duration: 3600)
        let records: [DateInterval] = [
            juneRecord2, mayRecord1, juneRecord1, julyRecord1
        ]
        
        let expectedSortedRecords = [[mayRecord1], [juneRecord1, juneRecord2], [julyRecord1]]
        
        XCTAssertEqual(
            ActivityListComponent.Model(records: records).sortedRecordsByMonth,
            expectedSortedRecords
        )
    }
}
