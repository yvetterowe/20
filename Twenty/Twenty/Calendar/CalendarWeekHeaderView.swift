//
//  CalendarWeekHeaderView.swift
//  Twenty
//
//  Created by Hao Luo on 6/23/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import CalendarKit
import SwiftUI

struct CalendarWeekHeaderView: UIViewRepresentable {
        
    typealias UIViewType = DayHeaderView
        
    private let selectDayStore: SelectDayStore
    
    init(selectDayStore: SelectDayStore) {
        self.selectDayStore = selectDayStore
    }
    
    func makeUIView(context: UIViewRepresentableContext<CalendarWeekHeaderView>) -> DayHeaderView {
        let header = DayHeaderView(calendar: .current)
        let initialState = DayViewState(date: Date(), calendar: .current)
        initialState.move(to: Date())
        header.state = initialState
        header.state?.subscribe(client: selectDayStore)
        return header
    }
    
    func updateUIView(_ uiView: DayHeaderView, context: UIViewRepresentableContext<CalendarWeekHeaderView>) {
        // no-op
    }
}

extension SelectDayStore: DayViewStateUpdating {
    
    func move(from oldDate: Date, to newDate: Date) {
        updateSelectDate(newDate)
    }
}
