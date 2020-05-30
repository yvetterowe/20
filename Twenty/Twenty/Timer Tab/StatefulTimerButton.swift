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
    
    private let timer: TwentyTimer
    @ObservedObject private var timerStateStore: TimerStateStore
    
    private enum Strings {
        static let startTrackingButtonTitle = "Start tracking"
        static let pauseButtonTitle = "Pause"
    }
    
    init(timerStateStore: TimerStateStore, timer: TwentyTimer) {
        self.timerStateStore = timerStateStore
        self.timer = timer
    }
    
    var body: some View {
        switch timerStateStore.state {
        case .inactive:
            return TimerButton(
                model: .init(
                    textModel: .init(
                        text: Strings.startTrackingButtonTitle,
                        textColor: SementicColorPalette.buttonTextColor,
                        textFont: .title // TODO: clean up font
                    ),
                    backgroundColorMode: .gradient(SementicColorPalette.timerGradient)) {
                        self.timer.sendAction(.start)
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
                self.timer.sendAction(.pause)
            }
           )
        }
    }
}

struct StatefulTimerButton_Previews: PreviewProvider {

    static let mockTimer = MockTimer()
    
    static var previews: some View {
        VStack {
            StatefulTimerButton(timerStateStore: .init(initialState: .inactive(0), timer: mockTimer), timer: mockTimer)
            StatefulTimerButton(timerStateStore: .init(initialState: .active(80), timer: mockTimer), timer: mockTimer)
        }
    }
}
