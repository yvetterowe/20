//
//  StatefulEditTimeView.swift
//  Twenty
//
//  Created by Hao Luo on 8/30/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol EditTimeViewWriter {
    func cancelEditTime()
    func saveEditTime(_ newDate: Date)
}

final class EditTimeViewStore: ObservableObject, EditTimeViewWriter {
    enum EditType {
        case start, end
    }
    
    @Binding private var editingTime: Bool
    @Published private(set) var editedDate: Date
    private var cancellable: Set<AnyCancellable> = .init()
    private let editType: EditType
    
    init(
        initialDate: Date,
        editingTime: Binding<Bool>,
        timeConfirmViewStateStore: TimeConfirmViewStateStore,
        type: EditType
    ) {
        self._editingTime = editingTime
        self._editedDate = .init(initialValue: initialDate)
        self.editType = type
        
        $editedDate
            .dropFirst()
            .removeDuplicates().sink { [weak self] newDate in
                print("new date: \(newDate)")
            guard let self = self else {
                return
            }
            
            switch self.editType {
            case .start:
                timeConfirmViewStateStore.updateStartDate(newDate)
            case .end:
                timeConfirmViewStateStore.updateEndDate(newDate)
            }
        }.store(in: &cancellable)
    }
    
    // MARK: - EditTimeViewWriter
    
    func cancelEditTime() {
        editingTime = false
    }
    
    func saveEditTime(_ newDate: Date) {
        editingTime = false
        editedDate = newDate
    }
}

struct StatefulEditTimeView: View {
    private let viewWriter: EditTimeViewWriter
    @State private var editingDate: Date
    
    init(initialDate: Date, viewWriter: EditTimeViewWriter) {
        self.viewWriter = viewWriter
        self._editingDate = .init(initialValue: initialDate)
    }
    
    var body: some View {
        NavigationView {
            DatePicker("", selection: $editingDate).datePickerStyle(WheelDatePickerStyle())
            .navigationBarTitle("Edit Time")
            .navigationBarItems(
                leading: Button(action: {
                    viewWriter.cancelEditTime()
                }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: {
                    viewWriter.saveEditTime(editingDate)
                }, label: {
                    Text("Done")
                }))
        }
    }
}

struct StatefulEditTimeView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulEditTimeView(
            initialDate: .init(),
            viewWriter: NoOpEditTimeViewWriter()
        )
    }
}
