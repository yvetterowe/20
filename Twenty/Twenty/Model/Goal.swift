//
//  Goal.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

struct Goal: Identifiable {
    let id: String
    let name: String
    let timeToComplete: TimeInterval
    let trackRecords: [TrackRecord]
    
    struct TrackRecord {
        let startDate: Date
        let endDate: Date
    }
    
    func totalTimeSpent(on date: Date) -> TimeInterval {
        // TODO
        return 100
    }
}
