//
//  DateTests.swift
//  TwentyTests
//
//  Created by Hao Luo on 5/27/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation
import XCTest
@testable import Twenty

class DateTests: XCTestCase {

    func testStripTime() {
        // Sunday, May 31, 2020 3:19:43 PM EST
        XCTAssertEqual(
            Date(timeIntervalSince1970: 1590952783).stripTime(),
            DateComponents(calendar: Calendar.current, year: 2020, month: 5, day: 31).date!
        )
        
        // Sunday, May 31, 2020 10:19:43 AM EST
        XCTAssertEqual(
            Date(timeIntervalSince1970: 1590934783).stripTime(),
            DateComponents(calendar: Calendar.current, year: 2020, month: 5, day: 31).date!
        )
        
        // Friday, May 31, 2019 10:19:43 AM EST
        XCTAssertEqual(
            Date(timeIntervalSince1970: 1559312383).stripTime(),
            DateComponents(calendar: Calendar.current, year: 2019, month: 5, day: 31).date!
        )
    }
}
