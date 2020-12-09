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
    @ObservedObject private var viewReader: ObservableWrapper<String>
    private let viewWriter: MoreActionListViewWriter
    private let context: Context
    
    @State private var addingTime: Bool = false
    @State private var editingGoal: Bool = false
    @State private var viewingActivities: Bool = false
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
                        addingTime = true
                    },
                    isSheetPresented: $addingTime
                ) {
                    AnyView(Text("Adding time placeholder"))
                },
                
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Edit Goal",
                    tapAction: {
                        editingGoal = true
                    },
                    isSheetPresented: $editingGoal
                ) {
                    let viewStore = EditGoalStore(
                        goalPublisher: context.goalPublisher,
                        goalStoreWriter: context.goalStoreWriter,
                        editing: $editingGoal
                    )
                    
                    AnyView(
                        StatefulEditGoalView(
                            goalNameReader: .init(publisher: viewStore.goalNamePublisher),
                            viewWriter: viewStore,
                            goalID: context.goalID
                        )
                    )
                },
                
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "View Activities",
                    tapAction: {
                        viewingActivities = true
                    },
                    isSheetPresented: $viewingActivities
                ) {
                    let viewStore = ViewActivityListViewStore(
                        goalPublisher: context.goalPublisher
                    )
                    AnyView(
                        StatefulViewActivityListView(
                            viewReader: .init(publisher: viewStore.publisher)
                        )
                    )
                },
                
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Delete Goal",
                    tapAction: {
                        deletingGoal = true
                    },
                    isSheetPresented: $deletingGoal
                ) {
                    AnyView(Text("Deleting goal placeholder"))
                },
            ]
        )
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

