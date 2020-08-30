//
//  StatefulTimerView.swift
//  Twenty
//
//  Created by Hao Luo on 8/12/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct TimerViewState {
    let isActive: Bool
    let elapsedTime: DateInterval?
}

final class TimerViewStateStore: ObservableObject {
    @Published private(set) var value: TimerViewState = .init(isActive: false, elapsedTime: nil)
    
    private let timerStateStore: TimerStateStore
    private let goalStoreWriter: GoalStoreWriter
    private let goalID: GoalID
    private var cancellable: AnyCancellable!
    
    init(timerStateStore: TimerStateStore, goalStoreWriter: GoalStoreWriter, goalID: GoalID) {
        self.timerStateStore = timerStateStore
        self.goalStoreWriter = goalStoreWriter
        self.goalID = goalID
        
        self.cancellable = timerStateStore.$state.sink { [weak self] timerState in
            guard let self = self else {
                return
            }
            
            self.value = .init(
                isActive: timerState.isActive,
                elapsedTime: timerState.elapsedTime
            )
        }
    }
    
    func timerButtonTapped() {
        timerStateStore.send(.toggleTimerButtonTapped)
    }
    
    func saveCurrentRecord() {
        guard let elapsedTime = value.elapsedTime else {
            print("Time not started yet")
            return
        }
        _ = goalStoreWriter.appendTrackRecord(
            .init(
                id: UUID().uuidString,
                timeSpan: elapsedTime
            ),
            forGoal: goalID
        )
    }
}

struct StatefulTimerView: View {
    
    struct ViewModel {
        var primaryText: String
        var buttonText: String
    }
    
    @ObservedObject private var viewStateStore: TimerViewStateStore
    @Binding private var presentingTimer: Bool
    @State private var dismissButtonEnabled: Bool = true
    @State private var buttonTappedCount: Int = 0 // ugly hack = =
    
    private var viewState: TimerViewState {
        return viewStateStore.value
    }
    
    init(viewStateStore: TimerViewStateStore, presentingTimer: Binding<Bool>) {
        self.viewStateStore = viewStateStore
        self._presentingTimer = presentingTimer
    }
    
    var body: some View {
        let viewModel = ViewModel(
            primaryText: viewState.primaryText,
            buttonText: viewState.buttonText
        )
        VStack {
            Spacer()
            Text(viewModel.primaryText)
            if let elapsedTime = viewState.elapsedTime {
                DateIntervalView(viewState: viewState) {
                    print("Edit start")
                } endTimeButtonAction: {
                    print("Edit end")
                }
            }
            Spacer()
            Button(viewModel.buttonText) {
                buttonTappedCount += 1
                dismissButtonEnabled = !dismissButtonEnabled
                viewStateStore.timerButtonTapped()
            }.disabled(buttonTappedCount >= 2)
            Button("Confirm and Save") {
                presentingTimer = false
                viewStateStore.saveCurrentRecord()
            }.disabled(!dismissButtonEnabled)
        }
    }
}

private struct DateIntervalView: View {
    let viewState: TimerViewState
    let startTimeButtonAction: () -> Void
    let endTimeButtonAction: () -> Void
    
    var body: some View {
        if let elapsedTime = viewState.elapsedTime {
            if viewState.isActive {
                Text("Start at \(elapsedTime.start.timeFormat())")
            } else {
                HStack {
                    Button("\(elapsedTime.start.timeFormat())", action: startTimeButtonAction)
                    Text("-")
                    Button("\(elapsedTime.end.timeFormat())", action: endTimeButtonAction)
                }
            }
        } else {
            Text("")
        }
    }
}

private extension TimerViewState {
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
