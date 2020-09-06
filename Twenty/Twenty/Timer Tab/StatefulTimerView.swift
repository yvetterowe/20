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
    var elapsedTime: DateInterval?
}

final class TimerViewStateStore: ObservableObject {
    
    @Published var value: TimerViewState = .init(isActive: false, elapsedTime: nil)
    
    private let timerStateStore: TimerStateStore
    private let goalStoreWriter: GoalStoreWriter
    private let goalID: GoalID
    private var cancellable: Set<AnyCancellable> = .init()
    
    init(
        timerStateStore: TimerStateStore,
        goalStoreWriter: GoalStoreWriter,
        goalID: GoalID
    ) {
        self.timerStateStore = timerStateStore
        self.goalStoreWriter = goalStoreWriter
        self.goalID = goalID
        
        timerStateStore.$state.sink { [weak self] timerState in
            guard let self = self else {
                return
            }
            
            self.value = .init(
                isActive: timerState.isActive,
                elapsedTime: timerState.elapsedTime
            )
        }.store(in: &cancellable)
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
    
    func updateFromConfirm(_ newElapsedTime: DateInterval) {
        self.value.elapsedTime = newElapsedTime
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
    @State private var editingTimerStartTime: Bool = false
    @State private var editingTimerEndTime: Bool = false
    
    private var viewState: TimerViewState {
        return viewStateStore.value
    }
    
    init(
        viewStateStore: TimerViewStateStore,
        presentingTimer: Binding<Bool>
    ) {
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
            if viewState.isActive {
                if let elapsedTime = viewState.elapsedTime {
                    Text("Start at \(elapsedTime.start.timeFormat())")
                }
            } else {
                if viewState.elapsedTime != nil {
                    StatefulTimeConfirmView(
                        viewStateStore: .init(
                            timerViewStore: viewStateStore,
                            initialElapsedTime: viewState.elapsedTime!
                        ),
                        initialElapsedTime: viewState.elapsedTime!,
                        editingStartTime: $editingTimerStartTime,
                        editingEndTime: $editingTimerEndTime
                    )
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

private extension TimerViewState {
    var primaryText: String {
        return elapsedTime?.duration.format() ?? "Om"
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

extension Date {
    func timeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func dayAndTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/M, HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
