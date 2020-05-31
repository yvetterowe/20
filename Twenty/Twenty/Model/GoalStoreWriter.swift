//
//  GoalStoreWriter.swift
//  Twenty
//
//  Created by Hao Luo on 5/31/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Foundation

protocol GoalStoreWriter {
    func appendTrackRecord(_ trackRecord: DateInterval, forGoal goalID: GoalID)
}
