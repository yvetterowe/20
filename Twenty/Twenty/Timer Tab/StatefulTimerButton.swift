//
//  StatefulTimerButton.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct StatefulTimerButton: View {
        
    @State private var state: ViewState
    enum ViewState {
        case inactive
        case active
    }
    
    private enum Strings {
        static let startTrackingButtonTitle = "Start tracking"
        static let pauseButtonTitle = "Pause"
    }
    
    init(viewState: ViewState) {
        self._state = .init(initialValue: viewState)
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
                    backgroundColorMode: .gradient(SementicColorPalette.timerGradient)
                )
            )
        
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
               )
           )
        }
    }
}

struct StatefulTimerButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatefulTimerButton(viewState: .inactive)
            StatefulTimerButton(viewState: .active)
        }
    }
}
