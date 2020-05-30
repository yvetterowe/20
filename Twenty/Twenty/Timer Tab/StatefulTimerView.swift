//
//  StatefulTimerView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct StatefulTimerView: View {
    
    @ObservedObject private var timerStateStore: TimerStateStore
    
    init(timerStateStore: TimerStateStore) {
        self.timerStateStore = timerStateStore
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
        switch timerStateStore.state {
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
            StatefulTimerView(timerStateStore: .init(initialState: .inactive(0), timer: MockTimer()))
            StatefulTimerView(timerStateStore: .init(initialState: .inactive(59), timer: MockTimer()))
            StatefulTimerView(timerStateStore: .init(initialState: .active(80), timer: MockTimer()))
            StatefulTimerView(timerStateStore: .init(initialState: .active(78305), timer: MockTimer()))
        }
    }
}
