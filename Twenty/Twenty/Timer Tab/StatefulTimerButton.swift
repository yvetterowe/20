//
//  StatefulTimerButton.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

typealias TimerButtonStateStore = Store<TimerButtonState, TimerButtonAction, TimerButtonContext>

enum TimerButtonState {
    case inactive
    case active
}

enum TimerButtonAction {
    case toggle
}

struct TimerButtonContext {
    let timer: TwentyTimer
}

func timerButtonStateReducer(state: inout TimerButtonState, action: TimerButtonAction, context: TimerButtonContext) {
    switch action {
    case .toggle:
        switch state {
        case .inactive:
            state = .active
            context.timer.resume()
            
        case .active:
            state = .inactive
            context.timer.suspend()
        }
    }
}

extension StatefulTimerButton {
    
    init(timer: TwentyTimer) {
        let timerButtonStateStore: TimerButtonStateStore = .init(
            initialState: .inactive,
            reducer: timerButtonStateReducer,
            context: .init(timer: timer)
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
