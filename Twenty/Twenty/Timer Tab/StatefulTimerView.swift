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
                case ( .active(_), let .active(newInterval)):
                subject.value = .active(newInterval)
                case ( .active(_), let .inactive(newInterval)):
                subject.value = .confirm(newInterval)
                case ( .confirm(_), let .active(newInterval)):
                subject.value = .active(newInterval)
                case ( .confirm(_), .inactive(_)):
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
    @State var viewOffsetState = CGSize.zero
    @State var isDragging = false
    @State var isPaused = false

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
        ZStack{
            ColorManager.Blue.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                
                VStack{
                    Spacer()
                    TimeLabelComponent(duration: viewState.elapsedTime.duration)
                    .foregroundColor(Color.White)
                    
                    if viewState.isActive {
                        Text("Start at \(viewState.elapsedTime.start.timeFormat())")
                            .linkButtonText()
                            .padding(10)

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
                }
                .offset(y: viewOffsetState.height * 2)
                
                HStack{
                    if (viewState.isActive){
                        Button("Pause"){
                                timerViewModelWriter.send(.pauseButtonTapped)
                        } .buttonStyle(LightSecondaryTextButtonStyle())
                        
                    }else{
                        Button("Confirm"){
                                presentingTimer = false
                                timerViewModelWriter.send(.confirmButtonTapped)
                        }.buttonStyle(LightSecondaryTextButtonStyle())
                        
                        Button("Cancel"){
                            timerViewModelWriter.send(.startButtonTapped)
                        }.buttonStyle(LightSecondaryTextButtonStyle())
                    }
                }
                .offset(y: viewOffsetState.height)
            }
            .background(ColorManager.Blue)
            .gesture(
                DragGesture()
                    .onChanged{value in
                        self.isDragging = true
                       self.viewOffsetState = value.translation
                        print(self.viewOffsetState.height * 1.6)
                    }
                    .onEnded{value in
                        self.isDragging = false
                        
                        if(viewOffsetState.height > -100){
                            print("cancel")
                            self.viewOffsetState = .zero
                            
                        }else if(viewOffsetState.height > -250 && -300 < viewOffsetState.height){
                            print("pause, show cancel button")
                            self.viewOffsetState = CGSize(width: 0, height: -320)
//                            timerViewModelWriter.send(.pauseButtonTapped)
                        }
                        
                        else{
                            print("stop")
                            self.viewOffsetState = CGSize(width: 0, height: -640)
//                            presentingTimer = false
//                            timerViewModelWriter.send(.confirmButtonTapped)
                        }
                        
                    }
            )
            
        }
    }
}

extension Date {
    func timeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
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
