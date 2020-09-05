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
    @Published private(set) var value: TimeConfirmViewState = .init(elapsedTime: nil)
    private var cancellable: Set<AnyCancellable> = .init()
    private let timerViewStore: TimerViewStateStore
    
    init(
        timerViewStore: TimerViewStateStore
    ) {
        self.timerViewStore = timerViewStore
        
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
    
    func setInitialElapsedTime(_ initialElapsedTime: DateInterval) {
        if initialElapsedTime != value.elapsedTime {
            value.elapsedTime = initialElapsedTime
        }
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
    @Binding private var editingTime: Bool
    
    init(
        viewStateStore: TimeConfirmViewStateStore,
        initialElapsedTime: DateInterval,
        editingTime: Binding<Bool>
    ) {
        self.viewStateStore = viewStateStore
        viewStateStore.setInitialElapsedTime(initialElapsedTime)
        self._editingTime = editingTime
    }
    
    private var viewState: TimeConfirmViewState {
        return viewStateStore.value
    }
    
    var body: some View {
        HStack {
            Button("\(viewState.elapsedTime!.start.timeFormat())") {
                editingTime = true
            }
            .sheet(isPresented: $editingTime) {
                StatefulEditTimeView(
                    initialDate: viewState.elapsedTime!.start,
                    viewStore: .init(
                        initialDate: viewState.elapsedTime!.start,
                        editingTime: $editingTime,
                        timeConfirmViewStateStore: viewStateStore,
                        type: .start
                    )
                )
            }
            
            Text("-")
            
            Button("\(viewState.elapsedTime!.end.timeFormat())") {
                editingTime = true
            }
            .sheet(isPresented: $editingTime) {
                StatefulEditTimeView(
                    initialDate: viewState.elapsedTime!.end,
                    viewStore: .init(
                        initialDate: viewState.elapsedTime!.end,
                        editingTime: $editingTime,
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
