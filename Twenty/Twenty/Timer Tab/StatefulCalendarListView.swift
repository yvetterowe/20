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
    func didSelectDay(_ day: Date.Day)
    func didCancel()
}

protocol CalendarListViewReader {
    var selectedDay: AnyPublisher<Date.Day, Never> { get }
}

final class CalendarListViewStore: CalendarListViewWriter, CalendarListViewReader {
    
    let selectedDay: AnyPublisher<Date.Day, Never>
    
    init(
        selectDayWriter: SelectDayStoreWriter,
        selectDayPublisher: AnyPublisher<Date.Day, Never>
    ) {
        self.selectedDay = selectDayPublisher
    }
    
    func didSelectDay(_ day: Date.Day) {
        
    }
    
    func didCancel() {
        
    }
}
 
struct StatefulCalendarListView: View {
    
    private let viewWriter: CalendarListViewWriter
    @State private var selectedDate: Date {
        didSet {
            viewWriter.didSelectDay(selectedDate.asDay(in: .current))
        }
    }
    
    init(
        initialSelectedDay: Date.Day,
        viewWriter: CalendarListViewWriter
    ) {
        self._selectedDate = .init(initialValue: initialSelectedDay.date)
        self.viewWriter = viewWriter
    }
    
    var body: some View {
        DatePicker("", selection: $selectedDate).datePickerStyle(WheelDatePickerStyle())
    }
}

struct StatefulCalendarListView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulCalendarListView(
            initialSelectedDay: Date().asDay(in: .current),
            viewWriter: NoOpCalendarListViewWriter()
        )
    }
}
