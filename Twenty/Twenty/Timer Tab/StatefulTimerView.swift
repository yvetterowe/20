//
//  StatefulTimerView.swift
//  Twenty
//
//  Created by Hao Luo on 8/12/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

enum TimerViewState {
    case active(DateInterval)
    case confirm(DateInterval)
    
    var elapsedTime: DateInterval {
        switch self {
        case let .active(interval): return interval
        case let .confirm(interval): return interval
        }
    }
    
    var isActive: Bool {
        switch self {
        case .active: return true
        case .confirm: return false
        }
    }
}

protocol TimerViewModelReader {
    var publisher: AnyPublisher<TimerViewState, Never> { get }
}

enum TimerViewAction {
    case startButtonTapped
    case pauseButtonTapped
    case confirmButtonTapped
    case resumeButtonTapped
    case timerStateUpdated(TimerState)
    case timeConfirmed(DateInterval)
}

protocol TimerViewModelWriter {
    func send(_ action: TimerViewAction)
}

final class TimerViewStateStore: TimerViewModelReader, TimerViewModelWriter {
    
    private let timerStatePublisher: AnyPublisher<TimerState, Never>
    private let timerStateWriter: TimerStateWriter

    private let goalStoreWriter: GoalStoreWriter
    private let goalID: GoalID
    
    private var subject: CurrentValueSubject<TimerViewState, Never> = .init(.active(.init()))
    private var cancellable: Set<AnyCancellable> = .init()
    
    init(
        timerStatePublisher: AnyPublisher<TimerState, Never>,
        timerStateWriter: TimerStateWriter,
        goalStoreWriter: GoalStoreWriter,
        goalID: GoalID
    ) {
        self.timerStatePublisher = timerStatePublisher
        self.timerStateWriter = timerStateWriter
        self.goalStoreWriter = goalStoreWriter
        self.goalID = goalID
        
        timerStateWriter.send(.toggleTimerButtonTapped)
        
        timerStatePublisher.sink { [weak self] timerState in
            guard let self = self else {
                return
            }
            self.send(.timerStateUpdated(timerState))
            
        }.store(in: &cancellable)
    }
    
    // MARK: - TimerViewModelReader
    
    var publisher: AnyPublisher<TimerViewState, Never> {
        return subject.eraseToAnyPublisher()
    }
        
    // MARK: - TimerViewModelWriter
    
    func send(_ action: TimerViewAction) {
        switch action {
        case .startButtonTapped:
            guard case let .confirm(interval) = subject.value else {
                fatalError("Timer should be in confirm state")
            }
            subject.value = .active(interval)
            timerStateWriter.send(.toggleTimerButtonTapped)
            
        case .pauseButtonTapped:
            guard case let .active(interval) = subject.value else {
                fatalError("Timer should be in active state")
            }
            subject.value = .confirm(interval)
            timerStateWriter.send(.toggleTimerButtonTapped)
            
        case .confirmButtonTapped:
            guard case let .confirm(interval) = subject.value else {
                fatalError("Timer should be in confirm state")
            }
            _ = goalStoreWriter.appendTrackRecord(
                .init(
                    id: UUID().uuidString,
                    timeSpan: interval
                ),
                forGoal: goalID
            )
        
        case .resumeButtonTapped:
            fatalError("Not implemented yet")
            
        case let .timerStateUpdated(newTimerState):
            switch (subject.value, newTimerState) {
            case (let .active(_), let .active(newInterval)):
                subject.value = .active(newInterval)
            case (let .active(_), let .inactive(newInterval)):
                subject.value = .confirm(newInterval)
            case (let .confirm(_), let .active(newInterval)):
                subject.value = .active(newInterval)
            case (let .confirm(interval), let .inactive(_)):
                break // no-op
            }
        
        case let .timeConfirmed(newInterval):
            guard case .confirm = subject.value else {
                fatalError("Timer should be in confirm state")
            }
            subject.value = .confirm(newInterval)
        }
    }
}

struct StatefulTimerView: View {
    
    @ObservedObject private var viewStateStore: ObservableWrapper<TimerViewState>
    private let timerViewModelWriter: TimerViewModelWriter
                
    @Binding private var presentingTimer: Bool
    @State private var editingTimerStartTime: Bool = false
    @State private var editingTimerEndTime: Bool = false

    private var viewState: TimerViewState {
        return viewStateStore.value
    }
    
    init(
        viewStateReader: ObservableWrapper<TimerViewState>,
        timerViewModelWriter: TimerViewModelWriter,
        presentingTimer: Binding<Bool>
    ) {
        self.viewStateStore = viewStateReader
        self.timerViewModelWriter = timerViewModelWriter
        self._presentingTimer = presentingTimer
    }
    
    var body: some View {
        VStack {
            Spacer()
            TimeLabelComponent(duration: viewState.elapsedTime.duration)
            if viewState.isActive {
                Text("Start at \(viewState.elapsedTime.start.timeFormat())")
            } else {
                StatefulTimeConfirmView(
                    viewStateStore: .init(
                        timerViewWriter: timerViewModelWriter,
                        initialElapsedTime: viewState.elapsedTime
                    ),
                    initialElapsedTime: viewState.elapsedTime,
                    editingStartTime: $editingTimerStartTime,
                    editingEndTime: $editingTimerEndTime
                )
            }
            Spacer()
            Button(viewState.isActive ? "Stop" : "Start") {
                if viewState.isActive {
                    timerViewModelWriter.send(.pauseButtonTapped)
                } else {
                    timerViewModelWriter.send(.startButtonTapped)
                }
            }.disabled(!viewState.isActive)
            Button("Confirm and Save") {
                presentingTimer = false
                timerViewModelWriter.send(.confirmButtonTapped)
                
            }.disabled(viewState.isActive)
        }
    }
}

extension Date {
    func timeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

struct StatefulTimerView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulTimerView(
            viewStateReader: .init(publisher: Just(TimerViewState.active(.init())).eraseToAnyPublisher()),
            timerViewModelWriter: NoOpTimerViewWriter(),
            presentingTimer: .constant(false)
        )
    }
}
