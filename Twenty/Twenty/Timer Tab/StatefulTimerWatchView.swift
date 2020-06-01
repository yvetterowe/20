//
//  StatefulTimerWatchView.swift
//  Twenty
//
//  Created by Hao Luo on 5/28/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct StatefulTimerWatchView: View {
    
    @ObservedObject private var timerViewStateStore: TimerViewStateStore
    
    init(timerViewStateStore: TimerViewStateStore) {
        self.timerViewStateStore = timerViewStateStore
    }
    
    enum ViewState {
        case loading
        case inactive(TimeInterval)
        case active(TimeInterval)
        
        var elapsedTime: TimeInterval {
            switch self {
            case .loading: return 0
            case let .inactive(time): return time
            case let .active(time): return time
            }
        }
    }
    
    var body: some View {
        switch timerViewStateStore.state {
        case .loading:
            return TimerWatchView(
                model: .init(
                    textModel: .init(
                        text: "loading...",
                        textColor: SementicColorPalette.defaultTextColor,
                        textFont: .title
                    ),
                    radius: 86,
                    backgroundColorMode: .single(.gray)
                )
            )
        case let .inactive(timeInterval):
            return TimerWatchView(
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
            return TimerWatchView(
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

struct StatefulTimerWatchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatefulTimerWatchView(timerViewStateStore: MockTimerFactory.timerViewStateStore(.loading))
            StatefulTimerWatchView(timerViewStateStore: MockTimerFactory.timerViewStateStore(.inactive(100)))
            StatefulTimerWatchView(timerViewStateStore: MockTimerFactory.timerViewStateStore(.active(100)))
        }
    }
}
