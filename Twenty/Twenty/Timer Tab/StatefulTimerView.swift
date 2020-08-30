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
        var buttonText: String
    }
    
    @ObservedObject private var timerStateStore: TimerStateStore
    @Binding private var presentingTimer: Bool
    @State private var dismissButtonEnabled: Bool = true
    @State private var buttonTappedCount: Int = 0 // ugly hack = =
    
    private var timerState: TimerState {
        return timerStateStore.state
    }
    
    init(timerStateStore: TimerStateStore, presentingTimer: Binding<Bool>) {
        self.timerStateStore = timerStateStore
        self._presentingTimer = presentingTimer
    }
    
    var body: some View {
        let viewModel = ViewModel(
            primaryText: timerState.primaryText,
            buttonText: timerState.buttonText
        )
        VStack {
            Spacer()
            Text(viewModel.primaryText)
            if let elapsedTime = timerState.elapsedTime {
                DateIntervalView(timerState: timerState) {
                    print("Edit start")
                } endTimeButtonAction: {
                    print("Edit end")
                }
            }
            Spacer()
            Button(viewModel.buttonText) {
                buttonTappedCount += 1
                dismissButtonEnabled = !dismissButtonEnabled
                timerStateStore.send(.toggleTimerButtonTapped)
            }.disabled(buttonTappedCount >= 2)
            Button("Confirm and Save") {
                presentingTimer = false
            }.disabled(!dismissButtonEnabled)
        }
    }
}

private struct DateIntervalView: View {
    let timerState: TimerState
    let startTimeButtonAction: () -> Void
    let endTimeButtonAction: () -> Void
    
    var body: some View {
        if let elapsedTime = timerState.elapsedTime {
            if timerState.isActive {
                Text("Start at \(elapsedTime.start.timeFormat())")
            } else {
                HStack {
                    Button("\(elapsedTime.start.timeFormat())", action: startTimeButtonAction)
                    Text("-")
                    Button("\(elapsedTime.start.timeFormat())", action: endTimeButtonAction)
                }
            }
        } else {
            Text("")
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

extension TimeInterval {
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
