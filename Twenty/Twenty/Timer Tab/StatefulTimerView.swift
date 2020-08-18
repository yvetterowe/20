//
//  StatefulTimerView.swift
//  Twenty
//
//  Created by Hao Luo on 8/12/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct StatefulTimerView: View {
    
    struct ViewModel {
        var primaryText: String
        var secondaryText: String
        var buttonText: String
    }
    
    @ObservedObject private var timerStateStore: TimerStateStore
    
    private var timerState: TimerState {
        return timerStateStore.state
    }
    
    init(timerStateStore: TimerStateStore) {
        self.timerStateStore = timerStateStore
    }
    
    var body: some View {
        let viewModel = ViewModel(
            primaryText: timerState.primaryText,
            secondaryText: timerState.secondaryText,
            buttonText: timerState.buttonText
        )
        VStack {
            Spacer()
            Text(viewModel.primaryText)
            Text(viewModel.secondaryText)
            Spacer()
            Button(viewModel.buttonText) {
                self.timerStateStore.send(.toggleTimerButtonTapped)
            }
        }
    }
}

private extension TimerState {
    var primaryText: String {
        return elapsedTime?.duration.format() ?? "Om"
    }
    
    var secondaryText: String {
        if isActive {
            return elapsedTime.map {"Start at \($0.start.timeFormat())" } ?? ""
        } else {
            return elapsedTime.map {"From \($0.start.timeFormat()) to \($0.end.timeFormat())"} ?? ""
        }
    }
    
    var buttonText: String {
        return isActive ? "Stop" : "Start"
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

private extension Date {
    func timeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
