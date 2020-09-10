//
//  MockGoal.swift
//  Twenty
//
//  Created by Hao Luo on 9/9/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

enum MockDataFactory {
    
    static let goal: GoalImpl = .init(
        id: "goal-id",
        name: "Learn SwiftUI",
        timeToComplete: 1000,
        trackRecords: []
    )
    
    static let today: Date.Day = Date().asDay(in: .current)
}
