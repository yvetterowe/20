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
    func goalPublisher(for goalID: GoalID) -> GoalPublisher
}

final class AnyGoalStoreReader<StoreReaderType: GoalStoreReader>: ObservableObject {
    
    private let storeReader: StoreReaderType
    
    init(_ storeReader: StoreReaderType) {
        self.storeReader = storeReader
    }
    
    func goalPublisher(for goalID: GoalID) -> GoalPublisher {
        return storeReader.goalPublisher(for: goalID)
    }
}



typealias GoalStore = Store<GoalState, GoalAction, GoalContext>

enum GoalState {
    case loading
    case loaed(Goal)
}

enum GoalAction {
    
}

struct GoalContext {
}


let goalStore: GoalStore = .init(
    initialState: .loading,
    reducer: goalReducer,
    context: GoalContext()
)

func goalReducer(state: inout GoalState, action: GoalAction, context: GoalContext) {
}
