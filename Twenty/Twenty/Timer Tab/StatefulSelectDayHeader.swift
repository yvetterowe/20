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

final class SelectDayStore: SelectDayStoreReader, ObservableObject {
    @Published var selectedDate: Date
        
    var selectDayPublisher: AnyPublisher<Date.Day, Never> {
        return $selectedDate.map{$0.asDay(in: .current)}.eraseToAnyPublisher()
    }
    
    init(initialSelectDay: Date.Day) {
        self._selectedDate = .init(initialValue: initialSelectDay.date)
    }
}

struct StatefulSelectDayHeader: View {
    
    @ObservedObject private var store: SelectDayStore
    
    init(store: SelectDayStore) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            DatePicker(selection: $store.selectedDate, displayedComponents: .date) {
                Text("Day")
            }
            Text("\(store.selectedDate)")
        }
    }
}
