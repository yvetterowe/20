//
//  StatefulEditGoalView.swift
//  Twenty
//
//  Created by Hao Luo on 9/13/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol EditGoalViewReader {
    var goalNamePublisher: AnyPublisher<String, Never> { get }
}

protocol EditGoalViewWriter {
    func cancelEditGoal()
    func saveEditGoalName(_ newGoalName: String, forGoal goalID: GoalID)
}

final class EditGoalStore: EditGoalViewReader, EditGoalViewWriter {
    
    private let goalStoreWriter: GoalStoreWriter
    @Binding private var editing: Bool
    
    init(
        goalPublisher: GoalPublisher,
        goalStoreWriter: GoalStoreWriter,
        editing: Binding<Bool>
    ) {
        self.goalNamePublisher = goalPublisher.map { $0.name }.eraseToAnyPublisher()
        self.goalStoreWriter = goalStoreWriter
        self._editing = editing
    }
    
    // MARK: EditGoalViewReader
    let goalNamePublisher: AnyPublisher<String, Never>
    
    // MARK: EditGoalViewWriter
    
    func cancelEditGoal() {
        editing = false
    }
    
    func saveEditGoalName(_ newGoalName: String, forGoal goalID: GoalID) {
        editing = false
        _ = goalStoreWriter.updateGoalName(newGoalName, forGoal: goalID)
    }
}

struct StatefulEditGoalView: View {
    private let viewWriter: EditGoalViewWriter
    private let goalID: GoalID
    @State private var editingGoalName: String = ""
    
    init(
        goalNameReader: ObservableWrapper<String>,
        viewWriter: EditGoalViewWriter,
        goalID: GoalID
    ) {
        self.viewWriter = viewWriter
        self._editingGoalName = .init(initialValue: goalNameReader.value)
        self.goalID = goalID
    }
    
    var body: some View {
        EditSheetComponent(
            navigationBarTitle: "Edit Goal") {
            viewWriter.cancelEditGoal()
        } onDone: {
            viewWriter.saveEditGoalName(editingGoalName, forGoal: goalID)
        } content: {
            TextField("Goal name", text: $editingGoalName)
        }

    }
}

struct StatefulEditGoalView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulEditGoalView(
            goalNameReader: .init(publisher: Just("Learn SwiftUI").eraseToAnyPublisher()),
            viewWriter: NoOpEditGoalViewWriter(),
            goalID: "goal-0"
        )
    }
}
