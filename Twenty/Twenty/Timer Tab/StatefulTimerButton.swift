//
//  StatefulTimerButton.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct StatefulTimerButton: View {
    
    @ObservedObject private var timerViewStateStore: TimerViewStateStore
    
    private enum Strings {
        static let startTrackingButtonTitle = "Start tracking"
        static let pauseButtonTitle = "Pause"
    }
    
    init(timerViewStateStore: TimerViewStateStore) {
        self.timerViewStateStore = timerViewStateStore
    }
    
    var body: some View {
        switch timerViewStateStore.state {
        case .loading:  // TODO(#12): Button should be disabled and untappable in loading state
            return TimerButton(
            model: .init(
                textModel: .init(
                    text: "Still loading...",
                    textColor: SementicColorPalette.buttonTextColor,
                    textFont: .title
                ),
                backgroundColorMode: .gradient(SementicColorPalette.timerGradient)) {}
            )
        
        case .inactive:
            return TimerButton(
                model: .init(
                    textModel: .init(
                        text: Strings.startTrackingButtonTitle,
                        textColor: SementicColorPalette.buttonTextColor,
                        textFont: .title // TODO: clean up font
                    ),
                    backgroundColorMode: .gradient(SementicColorPalette.timerGradient)) {
                        self.timerViewStateStore.send(.timerButtonTapped)
                })
        
        case .active:
           return TimerButton(
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
                self.timerViewStateStore.send(.timerButtonTapped)
            }
           )
        }
    }
}

struct StatefulTimerButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatefulTimerButton(timerViewStateStore: MockTimerFactory.timerViewStateStore(.loading))
            StatefulTimerButton(timerViewStateStore: MockTimerFactory.timerViewStateStore(MockTimerFactory.inactiveState))
            StatefulTimerButton(timerViewStateStore: MockTimerFactory.timerViewStateStore(MockTimerFactory.activeState))
        }
    }
}
