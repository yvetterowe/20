//
//  StatefulTimeConfirmView.swift
//  Twenty
//
//  Created by Hao Luo on 9/3/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct TimeConfirmViewState: Equatable {
    var elapsedTime: DateInterval?
}

final class TimeConfirmViewStateStore: ObservableObject {
    @Published private(set) var value: TimeConfirmViewState
    private var cancellable: Set<AnyCancellable> = .init()
    private let timerViewStore: TimerViewStateStore
    
    init(
        timerViewStore: TimerViewStateStore,
        initialElapsedTime: DateInterval
    ) {
        self.timerViewStore = timerViewStore
        self._value = .init(initialValue: .init(elapsedTime: initialElapsedTime))
        
        self.$value
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] newConfirmState in
            guard self != nil else {
                return
            }
            if let elapsedTime = newConfirmState.elapsedTime {
                timerViewStore.updateFromConfirm(elapsedTime)
            }
        }.store(in: &cancellable)
    }
    
    func updateStartDate(_ newStartDate: Date) {
        value.elapsedTime = .init(
            start: newStartDate,
            end: value.elapsedTime!.end
        )
    }
    
    func updateEndDate(_ newEndDate: Date) {
        value.elapsedTime = .init(
            start: value.elapsedTime!.start,
            end: newEndDate
        )
    }
}

struct StatefulTimeConfirmView: View {
    @ObservedObject private var viewStateStore: TimeConfirmViewStateStore
    @Binding private var editingStartTime: Bool
    @Binding private var editingEndTime: Bool
    
    init(
        viewStateStore: TimeConfirmViewStateStore,
        initialElapsedTime: DateInterval,
        editingStartTime: Binding<Bool>,
        editingEndTime: Binding<Bool>
    ) {
        self.viewStateStore = viewStateStore
        self._editingStartTime = editingStartTime
        self._editingEndTime = editingEndTime
    }
    
    private var viewState: TimeConfirmViewState {
        return viewStateStore.value
    }
    
    var body: some View {
        HStack {
            Button("\(viewState.elapsedTime!.start.timeFormat())") {
                editingStartTime = true
            }
            .sheet(isPresented: $editingStartTime) {
                StatefulEditTimeView(
                    initialDate: viewState.elapsedTime!.start,
                    viewStore: .init(
                        initialDate: viewState.elapsedTime!.start,
                        editingTime: $editingStartTime,
                        timeConfirmViewStateStore: viewStateStore,
                        type: .start
                    )
                )
            }
            
            Text("-")
            
            Button("\(viewState.elapsedTime!.end.timeFormat())") {
                editingEndTime = true
            }
            .sheet(isPresented: $editingEndTime) {
                StatefulEditTimeView(
                    initialDate: viewState.elapsedTime!.end,
                    viewStore: .init(
                        initialDate: viewState.elapsedTime!.end,
                        editingTime: $editingEndTime,
                        timeConfirmViewStateStore: viewStateStore,
                        type: .end
                    )
                )
            }
        }
    }
}

//struct StatefulTimeConfirmView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulTimeConfirmView()
//    }
//}