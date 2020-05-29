//
//  StatefulTimerView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

final class TimerViewStateStore: ObservableObject, Subscriber {
    
    @Published private(set) var state: StatefulTimerView.ViewState
    
    init(initialState: StatefulTimerView.ViewState, timer: Timer) {
        self._state = .init(initialValue: initialState)
        timer.state.subscribe(self)
    }
    // MARK: - Subscriber
    
    typealias Input = TimerState
    typealias Failure = Never
    
    var combineIdentifier: CombineIdentifier {
        return .init()
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: TimerState) -> Subscribers.Demand {
        switch(state, input) {
        case (.inactive, .inactive):
            break
        case (let .active(viewTime), .inactive):
            state = .inactive(viewTime)
        case (_, let .active(timerTime)):
            state = .active(timerTime)
        }
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        self.state = .inactive(state.elapsedTime)
    }
}

struct StatefulTimerView: View {
    
    @ObservedObject private var viewStateStore: TimerViewStateStore
    
    init(viewStateStore: TimerViewStateStore) {
        self.viewStateStore = viewStateStore
    }
    
    enum ViewState {
        case inactive(TimeInterval)
        case active(TimeInterval)
        
        var elapsedTime: TimeInterval {
            switch self {
            case let .inactive(time): return time
            case let .active(time): return time
            }
        }
    }
    
    var body: some View {
        switch viewStateStore.state {
        case let .inactive(timeInterval):
            return TimerView(
                model: .init(
                    textModel: .init(
                        text: timeInterval.format(),
                        textColor: SementicColorPalette.defaultTextColor,
                        textFont: .title
                    ),
                    radius: 86,
                    backgroundColorMode: .single(.gray)
                )
            )
            
        case let .active(timeInterval):
            return TimerView(
                model: .init(
                    textModel: .init(
                        text: timeInterval.format(),
                        textColor: SementicColorPalette.defaultTextColor,
                        textFont: .title
                    ),
                    radius: 125,
                    backgroundColorMode: .gradient(SementicColorPalette.timerGradient)
                )
            )
        }
    }
}

private extension TimeInterval {
    func format() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

struct StatefulTimerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatefulTimerView(viewStateStore: .init(initialState: .inactive(0), timer: MockTimer()))
            StatefulTimerView(viewStateStore: .init(initialState: .inactive(59), timer: MockTimer()))
            StatefulTimerView(viewStateStore: .init(initialState: .active(80), timer: MockTimer()))
            StatefulTimerView(viewStateStore: .init(initialState: .active(78305), timer: MockTimer()))
        }
    }
}
