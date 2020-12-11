//
//  HomeViewController.swift
//  Twenty
//
//  Created by Effy Zhang on 6/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

private enum HomeViewState {
    case loading
    case loaded(GoalID)
}

private final class HomeViewStateStore: ObservableObject {
    @Published private(set) var state: HomeViewState = .loading
    
    private var cancellable: AnyCancellable!
    
    init(firstGoalPublisher: AnyPublisher<Goal?, Never>) {
        cancellable = firstGoalPublisher.sink { [unowned self] firstGoal in
            guard let firstGoal = firstGoal else {
                return
            }
            
            let goalID = firstGoal.id
            
            self.state = .loaded(goalID)
        }
    }
}

extension HomeWrapperView {
    init(userID: String, authService: AuthenticationService) {
        let goalStore = GoalStoreImpl(
            persistentDataStore: FirebasePersistentDataStore(userID: userID)
        )
        
        self.init(
            goalStore: goalStore,
            viewStateStore: .init(firstGoalPublisher: goalStore.firstGoalPublisher),
            authService: authService
        )
    }
}

struct HomeWrapperView: View {
    
    @ObservedObject fileprivate var viewStateStore: HomeViewStateStore
    private let goalStore: GoalStoreImpl
    private let currentDate: Date.Day
    private let authService: AuthenticationService
    
    fileprivate init(goalStore: GoalStoreImpl, viewStateStore: HomeViewStateStore, authService: AuthenticationService) {
        self.goalStore = goalStore
        self.viewStateStore = viewStateStore
        self.currentDate = Date().asDay(in: .current)
        self.authService = authService
    }
    
    var body: some View {
        switch viewStateStore.state {
        case .loading: Text("Loading home view...")
        case let .loaded(goalID):
            ContentView(
                timerTabContext: .init(
                    goalID: goalID,
                    goalStoreWriter: goalStore,
                    goalPublisher: AnyGoalStoreReader(goalStore).goalPublisher(for: goalID),
                    selectDayStore: .init(initialSelectDay: currentDate),
                    todayPublisher: Just(currentDate).eraseToAnyPublisher(),
                    authService: authService
                )
            )
        }
    }
}
