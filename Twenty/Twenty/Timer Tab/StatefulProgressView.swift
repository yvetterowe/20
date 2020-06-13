//
//  StatefulProgressView.swift
//  Twenty
//
//  Created by Hao Luo on 6/12/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct ProgressViewState {
    var progressDescription: String
    var progressState: ProgressState
    enum ProgressState: Equatable {
        case noProgress
        case someProgress(Float)
    }
}

final class ProgressViewStateStore: ObservableObject, Subscriber {
    @Published private(set) var state: ProgressViewState = .init(progressDescription: "", progressState: .noProgress)
    
    init(goalPublisher: GoalPublisher) {
        goalPublisher.subscribe(self)
    }
    
    // MARK: - Subscriber
    
    typealias Input = Goal
    typealias Failure = Never
    
    func receive(_ goal: Goal) -> Subscribers.Demand {
        let progress: Float = Float(goal.totalTimeSpent / goal.timeToComplete)
        let progressDescription = "\(Int(progress * 100))% \(goal.name)"
        
        if goal.totalTimeSpent == 0 {
            state = .init(
                progressDescription: progressDescription,
                progressState: .noProgress
            )
        } else {
            state = .init(
                progressDescription: progressDescription,
                progressState: .someProgress(progress)
            )
        }
        
        return .unlimited
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        
    }
}

extension StatefulProgressView {
    init(goalPublisher: GoalPublisher) {
        self.init(
            viewStateStore: .init(goalPublisher: goalPublisher)
        )
    }
}

struct StatefulProgressView: View {
    @ObservedObject private var viewStateStore: ProgressViewStateStore
    
    init(viewStateStore: ProgressViewStateStore) {
        self.viewStateStore = viewStateStore
    }
    
    private let progressBarWidth: CGFloat = 102
    
    private func progress(for state: ProgressViewState.ProgressState, progressBarHeight: CGFloat) -> Float {
        switch state {
        case .noProgress:
            return Float(progressBarHeight / progressBarWidth)
        case let .someProgress(progress):
            return progress
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ProgressView(
                model: .init(
                    title: .init(
                        text: self.viewStateStore.state.progressDescription,
                        textColor: SementicColorPalette.defaultTextColor,
                        textFont: .body
                    ),
                    progressBar: .init(
                        progress: self.progress(for: self.viewStateStore.state.progressState, progressBarHeight: geometry.size.height),
                        foregroundColor: SementicColorPalette.progressBarColor,
                        foregroundOpacity: 1.0,
                        backgroundColor: SementicColorPalette.progressBarColor,
                        backgroundOpacity: 0.3,
                        cornerRadius: 8
                    ),
                    progressBarWidth: self.progressBarWidth
                )
            )
        }
    }
}
