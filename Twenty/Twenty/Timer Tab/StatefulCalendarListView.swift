//
//  StatefulCalendarListView.swift
//  Twenty
//
//  Created by Hao Luo on 9/19/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol CalendarListViewWriter {
    func didCancel()
}

final class CalendarListViewStore: CalendarListViewWriter, ObservableObject {
    @Published var selectedDate: Date {
        didSet {
            selectDayWriter.updateSelectDate(selectedDate)
            presentingCalendar = false
        }
    }
    
    private let selectDayWriter: SelectDayStoreWriter
    @Binding private var presentingCalendar: Bool
    
    init(
        initialSelectedDay: Date,
        selectDayWriter: SelectDayStoreWriter,
        presentingCalendar: Binding<Bool>
    ) {
        self._selectedDate = .init(initialValue: initialSelectedDay)
        self._presentingCalendar = presentingCalendar
        self.selectDayWriter = selectDayWriter
    }
    
    // MARK: CalendarListViewWriter
    
    func didCancel() {
        presentingCalendar = false
    }
}
 
struct StatefulCalendarListView: View {
    
    @Binding private var selectedDay: Date
    init(
        selectedDay: Binding<Date>
    ) {
        self._selectedDay = selectedDay
    }
    
    var body: some View {
        DatePicker("", selection: $selectedDay).datePickerStyle(WheelDatePickerStyle())
    }
}

struct StatefulCalendarListView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulCalendarListView(selectedDay: .constant(Date()))
    }
}
