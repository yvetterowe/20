//
//  StatefulSelectDayHeader.swift
//  Twenty
//
//  Created by Hao Luo on 6/9/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol SelectDayStoreReader {
    var selectDayPublisher: AnyPublisher<Date.Day, Never> { get }
}

protocol SelectDayStoreWriter {
    func updateSelectDate(_ date: Date)
}

final class SelectDayStore: SelectDayStoreReader, SelectDayStoreWriter, ObservableObject {
    @Published private(set) var selectedDate: Date
        
    var selectDayPublisher: AnyPublisher<Date.Day, Never> {
        return $selectedDate.map{$0.asDay(in: .current)}.eraseToAnyPublisher()
    }
    
    init(initialSelectDay: Date.Day) {
        self._selectedDate = .init(initialValue: initialSelectDay.date)
    }
    
    func updateSelectDate(_ date: Date) {
        selectedDate = date
    }
}

struct StatefulSelectDayHeader: View {
    
    @ObservedObject private var store: SelectDayStore
    
    init(store: SelectDayStore) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            CalendarWeekHeaderView(selectDayStore: store)
                .frame(height: 96)
        }
    }
}

struct StatefulSelectDayHeader_Previews: PreviewProvider {
    static var previews: some View {
        StatefulSelectDayHeader(store: .init(initialSelectDay: Date().asDay(in: .current)))
    }
}
