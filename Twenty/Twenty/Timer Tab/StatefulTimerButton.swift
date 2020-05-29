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
    
    @State private var state: ViewState {
        didSet {
            if state == oldValue {
                return
            }
            switch state {
            case .inactive:
                timer.sendAction(.pause)
            case .active:
                timer.sendAction(.start)
            }
        }
    }
    
    enum ViewState: Equatable {
        case inactive
        case active
    }
    
    private enum Strings {
        static let startTrackingButtonTitle = "Start tracking"
        static let pauseButtonTitle = "Pause"
    }
    
    init(viewState: ViewState, timer: TwentyTimer) {
        self._state = .init(initialValue: viewState)
        self.timer = timer
    }
    
    var body: some View {
        switch state {
        case .inactive:
            return TimerButton(
                model: .init(
                    textModel: .init(
                        text: Strings.startTrackingButtonTitle,
                        textColor: SementicColorPalette.buttonTextColor,
                        textFont: .title // TODO: clean up font
                    ),
                    backgroundColorMode: .gradient(SementicColorPalette.timerGradient)) {
                        self.state = .active
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
                self.state = .inactive
            }
           )
        }
    }
}

struct StatefulTimerButton_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            StatefulTimerButton(viewState: .inactive, timer: MockTimer())
            StatefulTimerButton(viewState: .active, timer: MockTimer())
        }
    }
}
