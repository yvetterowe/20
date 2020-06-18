//
//  Goal.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

typealias GoalID = String

struct TrackRecord: Codable, Identifiable {
    let id: UUID
    let timeSpan: DateInterval
    
    init(timeSpan: DateInterval){
        self.id = UUID()
        self.timeSpan = timeSpan
    }
}

protocol Goal {
    var id: GoalID { get }
    var name: String { get }
    var timeToComplete: TimeInterval { get }
    var trackRecords: [TrackRecord] { get }
    var totalTimeSpent: TimeInterval { get }
    func totalTimeSpent(on day: Date.Day) -> TimeInterval
}
