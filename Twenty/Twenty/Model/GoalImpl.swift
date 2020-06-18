//
//  GoalImpl.swift
//  Twenty
//
//  Created by Hao Luo on 6/17/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

struct GoalImpl: Goal, Identifiable, Codable {
    let id: GoalID
    let name: String
    let timeToComplete: TimeInterval
    
    private(set) var trackRecords: [TrackRecord]
    private(set) var totalTimeSpent: TimeInterval
    private var timeSpentByDay: [Date.Day: TimeInterval]
    
    init(id: GoalID, name: String, timeToComplete: TimeInterval, trackRecords: [TrackRecord]) {
        self.id = id
        self.name = name
        self.timeToComplete = timeToComplete
        self.trackRecords = []
        self.totalTimeSpent = 0
        self.timeSpentByDay = [:]
        
        trackRecords.forEach {
            self.appendTrackRecord($0)
        }
    }
    
    func totalTimeSpent(on day: Date.Day) -> TimeInterval {
        return timeSpentByDay[day] ?? 0
    }
    
    mutating func appendTrackRecord(_ trackRecord: TrackRecord) {
        print("Track record added! \(trackRecord)")
        trackRecords.append(trackRecord)
        
        // TODO(#13): handle `trackRecord` spreads across multiple days
        let day = trackRecord.timeSpan.start.asDay(in: .current)
        timeSpentByDay[day] = (timeSpentByDay[day] ?? 0) + trackRecord.timeSpan.duration
        totalTimeSpent += trackRecord.timeSpan.duration
    }
}
