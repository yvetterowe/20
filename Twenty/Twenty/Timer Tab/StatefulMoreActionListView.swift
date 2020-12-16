//
//  StatefulMoreActionListView.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol MoreActionListViewReader {
    var titlePublisher: AnyPublisher<String, Never> { get }
}

enum MoreActionListViewAction {
    case addTime
    case editGoal
    case viewActivity
    case deleteGoal
}

protocol MoreActionListViewWriter {
    func send(_ action: MoreActionListViewAction)
}

final class MoreActionListViewStore: MoreActionListViewReader, MoreActionListViewWriter {
    
    init(goalPublisher: GoalPublisher) {
        self.titlePublisher = goalPublisher
            .map{ $0.name }
            .eraseToAnyPublisher()
    }
    
    // MARK: MoreActionListViewReader
    
    let titlePublisher: AnyPublisher<String, Never>
    
    // MARK: MoreActionListViewWriter
    
    func send(_ action: MoreActionListViewAction) {
        switch action {
        case .addTime:
            print("add time")
        case .editGoal:
            print("edit goal")
        case .viewActivity:
            print("view activity")
        case .deleteGoal:
            print("delete goal")
        }
    }
}

struct StatefulMoreActionListView: View {
    
    enum ActiveSheet: Identifiable {
        case addTime, editGoal, viewActivities
        
        var id: Int {
            hashValue
        }
    }
    
    @ObservedObject private var viewReader: ObservableWrapper<String>
    private let viewWriter: MoreActionListViewWriter
    private let context: Context
    
    @State private var editingGoal: Bool = false
    @State private var activeSheet: ActiveSheet?
    @State private var deletingGoal: Bool = false
    
    init(
        viewReader: ObservableWrapper<String>,
        viewWriter: MoreActionListViewWriter,
        context: Context
    ) {
        self.viewReader = viewReader
        self.viewWriter = viewWriter
        self.context = context
    }
    
    var body: some View {
        MoreActionListComponent(
            rows: [
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Add Time",
                    tapAction: {
                        activeSheet = .addTime
                    }
                ),
                
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Edit Goal",
                    tapAction: {
                        editingGoal = true
                        activeSheet = .editGoal
                    }
                ),
                
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "View Activities",
                    tapAction: {
                        activeSheet = .viewActivities
                    }
                ),
                
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Delete Goal",
                    tapAction: {
                        deletingGoal = true
                    }
                ),
            ]
        )
        .sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
            case .addTime:
                Text("Adding time placeholder")
            case .editGoal:
                let viewStore = EditGoalStore(
                    goalPublisher: context.goalPublisher,
                    goalStoreWriter: context.goalStoreWriter,
                    editing: $editingGoal
                )
                StatefulEditGoalView(
                    goalNameReader: .init(publisher: viewStore.goalNamePublisher),
                    viewWriter: viewStore,
                    goalID: context.goalID
                )
            case .viewActivities:
                let viewStore = ViewActivityListViewStore(
                    goalPublisher: context.goalPublisher
                )
                StatefulViewActivityListView(
                    viewReader: .init(publisher: viewStore.publisher)
                )
            }
        })
    }
}

struct StatefulMoreActionListView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulMoreActionListView(
            viewReader: .init(publisher: Just("Learn SwiftUI").eraseToAnyPublisher()),
            viewWriter: NoOpMoreActionListViewWriter(),
            context: MockDataFactory.context
        )
    }
}

