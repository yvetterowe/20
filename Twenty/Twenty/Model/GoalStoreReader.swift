//
//  GoalStoreReader.swift
//  Twenty
//
//  Created by Hao Luo on 5/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

typealias GoalPublisher = AnyPublisher<Goal, Never>

protocol GoalStoreReader: ObservableObject {
    func goalPublisher(for goalID: Goal.ID) -> GoalPublisher
}
