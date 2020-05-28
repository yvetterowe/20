//
//  StatefulTimerView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct StatefulTimerView: View {
    
    @State private var state: ViewState
    
    init(viewState: ViewState) {
        self._state = .init(initialValue: viewState)
    }
    
    enum ViewState {
        case inactive
        case active(TimeInterval)
    }
    
    var body: some View {
        switch state {
        case .inactive:
            return TimerView(
                model: .init(
                    textModel: .init(
                        text: "00:00",
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
            StatefulTimerView(viewState: .inactive)
            StatefulTimerView(viewState: .active(59))
            StatefulTimerView(viewState: .active(80))
            StatefulTimerView(viewState: .active(78305))
        }
    }
}
