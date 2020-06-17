//
//  StatefulTimerButton.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

enum TimerButtonState {
    case inactive
    case active
}

enum TimerButtonAction {
    case toggle
}

final class TimerButtonStateStore: ObservableObject, Subscriber {
    
    @Published private(set) var state: TimerButtonState = .inactive
    private let timer: TwentyTimer
    
    init(
        timer: TwentyTimer,
        timerStatePublisher: AnyPublisher<TimerState, Never>
    ) {
        self.timer = timer
        timerStatePublisher.subscribe(self)
    }
    
    func send(_ action: TimerButtonAction) {
        switch state {
        case .inactive:
            state = .active
            timer.resume()
        
        case .active:
            state = .inactive
            timer.suspend()
        }
    }
    
    // MARK: - Subscriber
    
    typealias Input = TimerState
    typealias Failure = Never
    
    func receive(_ input: Input) -> Subscribers.Demand {
        switch input.activeState {
        case .inactive:
            state = .inactive
        case .active:
            state = .active
        }
        
        return .unlimited
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        
    }

}

extension StatefulTimerButton {
    
    init(context: StatefulTimerTabView.Context) {
        let timerButtonStateStore: TimerButtonStateStore = .init(
            timer: context.timer,
            timerStatePublisher: context.timerStateStore.timerStatePublisher
        )
        
        self.init(buttonStateStore: timerButtonStateStore)
    }
}

struct StatefulTimerButton: View {
    
    @ObservedObject private var buttonStateStore: TimerButtonStateStore
    
    private enum Strings {
        static let startTrackingButtonTitle = "Start tracking"
        static let pauseButtonTitle = "Pause"
    }
    
    init(buttonStateStore: TimerButtonStateStore) {
        self.buttonStateStore = buttonStateStore
    }
    
    var body: some View {
        switch buttonStateStore.state {
            case .inactive:
                return TextButton(
                    model: .init(
                        textModel: .init(
                            text: Strings.startTrackingButtonTitle,
                            textColor: SementicColorPalette.buttonTextColor,
                            textFont: .title // TODO: clean up font
                        ),
                        backgroundColorMode: .gradient(SementicColorPalette.timerGradient)) {
                            self.buttonStateStore.send(.toggle)
                    })
            case .active:
               return TextButton(
                   model: .init(
                       textModel: .init(
                           text: Strings.pauseButtonTitle,
                           textColor: SementicColorPalette.buttonTextColor,
                           textFont: .title
                       ),
                       backgroundColorMode: .single(.clear),
                       border: .some(
                        color: SementicColorPalette.buttonBorderColor,
                        width: 1,
                        cornerRadius: 24
                       )
                   ) {
                    self.buttonStateStore.send(.toggle)
                   }
                )
        }
    }
}

//struct StatefulTimerButton_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            StatefulTimerButton(TimerStateStore: MockTimerFactory.TimerStateStore(.loading))
//            StatefulTimerButton(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.inactiveState))
//            StatefulTimerButton(TimerStateStore: MockTimerFactory.TimerStateStore(MockTimerFactory.activeState))
//        }
//    }
//}
