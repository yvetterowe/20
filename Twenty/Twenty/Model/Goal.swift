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
    let id: String
    let timeSpan: DateInterval
}

protocol Goal {
    var id: GoalID { get }
    var name: String { get }
    var timeToComplete: TimeInterval { get }
    var trackRecords: [TrackRecord] { get }
    var totalTimeSpent: TimeInterval { get }
    func totalTimeSpent(on day: Date.Day) -> TimeInterval
}

extension Goal {
    
    var remainingTime: TimeInterval {
        return timeToComplete - totalTimeSpent
    }
    
    var avgTimePerDay: TimeInterval {
        let totalTime = trackRecords.map {$0.timeSpan.duration}.reduce(0, +)
        let dayCount = Dictionary(grouping: trackRecords, by: { $0.timeSpan.start.asDay(in: .current)}).keys.count
        return totalTime / TimeInterval(dayCount)
    }
    
    var recordsCount: Int {
        return trackRecords.count
    }
    
    func streakCount(asOf day: Date.Day) -> Int {
        let recordsAsOfDay = records(asOf: day)
            .sorted { $0.start.asDay(in: .current) < $1.start.asDay(in: .current) }
        
        var streak = 0
        var referenceDay = day
        
        // TODO
        return 0
    }
    
    private func records(asOf day: Date.Day) -> [DateInterval] {
        return trackRecords
            .map { $0.timeSpan }
            .filter { $0.start.asDay(in: .current) <= day }
    }
}
