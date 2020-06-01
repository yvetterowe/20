//
//  Store.swift
//  Twenty
//
//  Created by Hao Luo on 6/1/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

typealias Reducer<State, Action, Context> = (inout State, Action, Context) -> Void

final class Store<State, Action, Context>: ObservableObject {
    private let reducer: Reducer<State, Action, Context>
    private let context: Context
    
    @Published private(set) var state: State
    
    init(initialState: State, reducer: @escaping Reducer<State, Action, Context>, context: Context) {
        self.state = initialState
        self.reducer = reducer
        self.context = context
    }
    
    func send(_ action: Action) {
        self.reducer(&state, action, context)
    }
}
