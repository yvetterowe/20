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
    
    init(
        viewReader: ObservableWrapper<String>,
        viewWriter: MoreActionListViewWriter
    ) {
        self.viewReader = viewReader
        self.viewWriter = viewWriter
    }
    
    var body: some View {
        MoreActionListComponent(
            title: viewReader.value,
            rows: [
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Add Time",
                    action: {
                        viewWriter.send(.addTime)
                    }
                ),
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Edit Goal",
                    action: {
                        viewWriter.send(.editGoal)
                    }
                ),
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "View Activities",
                    action: {
                        viewWriter.send(.viewActivity)
                    }
                ),
                .init(
                    icon: Image(systemName: "number.square"),
                    title: "Delete Goal",
                    action: {
                        viewWriter.send(.deleteGoal)
                    }
                )
            ]
        )
    }
}

struct StatefulMoreActionListView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulMoreActionListView(
            viewReader: .init(publisher: Just("Learn SwiftUI").eraseToAnyPublisher()),
            viewWriter: NoOpMoreActionListViewWriter()
        )
    }
}

