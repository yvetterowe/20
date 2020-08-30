//
//  StatefulEditTimeView.swift
//  Twenty
//
//  Created by Hao Luo on 8/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

final class StatefulEditTimeViewStore: ObservableObject {
//    @Published private(set) var dateInterval: DateInterval
    @Binding var editingTime: Bool
    @Binding var dateInterval: DateInterval
    
    init(editingTime: Binding<Bool>, dateInterval: Binding<DateInterval>) {
        self._dateInterval = dateInterval
        self._editingTime = editingTime
    }
    
    func cancelEditTime() {
        editingTime = false
    }
    
    func saveEditTime(_ newDateInterval: DateInterval) {
        editingTime = false
        dateInterval = newDateInterval
    }
}

struct StatefulEditTimeView: View {
    @ObservedObject private var viewStore: StatefulEditTimeViewStore
    
    init(viewStore: StatefulEditTimeViewStore) {
        self.viewStore = viewStore
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewStore.dateInterval.duration.format())
                Text("Start at \(viewStore.dateInterval.start.dayAndTimeFormat())")
                Text("End at \(viewStore.dateInterval.end.dayAndTimeFormat())")
            }
            .navigationBarTitle("Edit Time")
            .navigationBarItems(
                leading: Button(action: {
                    viewStore.cancelEditTime()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    viewStore.saveEditTime(.init())
                }, label: {
                    Text("Done")
                }))
        }
    }
}

//struct StatefulEditTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulEditTimeView()
//    }
//}
