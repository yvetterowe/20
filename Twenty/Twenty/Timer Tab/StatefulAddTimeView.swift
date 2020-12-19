//
//  StatefulAddTimeView.swift
//  Twenty
//
//  Created by Hao Luo on 12/15/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

protocol AddTimeViewWriter {
    func cancel()
    func save(_ newRecord: TrackRecord)
}

final class AddTimeViewStore: AddTimeViewWriter {
    
    func cancel() {
        // TODO
    }
    
    func save(_ newRecord: TrackRecord) {
        // TODO
    }
}

struct StatefulAddTimeView: View {
    enum ActiveSheet: Identifiable {
        case editStartTime, editEndTime
        
        var id: Int {
            hashValue
        }
    }
    
    @State private var activeSheet: ActiveSheet?
    @State private var newRecord: TrackRecord
    private let viewWriter: AddTimeViewWriter
    
    init(viewWriter: AddTimeViewWriter, initialDateInterval: DateInterval) {
        self.viewWriter = viewWriter
        self._newRecord = .init(initialValue: .init(id: UUID().uuidString, timeSpan: initialDateInterval))
    }
    
    var body: some View {
        EditSheetComponent(
            navigationBarTitle: "Add Time"
        ) {
            viewWriter.cancel()
        } onDone: {
            viewWriter.save(newRecord)
        } content: {
            AddTimeComponent(
                dateInterval: newRecord.timeSpan
            ) {
                activeSheet = .editStartTime
            } editEndTimeAction: {
                activeSheet = .editEndTime
            }
        }
        .sheet(item: $activeSheet) { activeSheet in
            switch activeSheet {
            case .editStartTime:
                Text("start")
            case .editEndTime:
                Text("end")
            }
        }
    }
}

struct StatefulAddTimeView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulAddTimeView(viewWriter: NoOpAddTimeViewWriter(), initialDateInterval: .init())
    }
}
