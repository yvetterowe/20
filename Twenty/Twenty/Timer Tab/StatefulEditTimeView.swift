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
    @State private var editingStartTime: Bool = false
    @State private var editingEndTime: Bool = false
    
    init(viewStore: StatefulEditTimeViewStore) {
        self.viewStore = viewStore
    }
    
    var body: some View {
        NavigationView {
            List {
                Text(viewStore.dateInterval.duration.format())
                TimeListRow(
                    model: .init(
                        title: "Start at",
                        buttonText: "\(viewStore.dateInterval.start.dayAndTimeFormat())",
                        buttonAction: {
                            self.editingStartTime = true
                        }
                    )
                )

                TimeListRow(
                    model: .init(
                        title: "End at",
                        buttonText: "\(viewStore.dateInterval.end.dayAndTimeFormat())",
                        buttonAction: {
                            self.editingEndTime = true
                        }
                    )
                )
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

struct TimeListRow: View {
    
    struct Model {
        let title: String
        let buttonText: String
        let buttonAction: () -> Void
    }
    
    let model: Model
    
    var body: some View {
        HStack {
            Text(model.title)
            Spacer()
            Button(model.buttonText, action: model.buttonAction)
        }
    }
}

//struct StatefulEditTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulEditTimeView()
//    }
//}
