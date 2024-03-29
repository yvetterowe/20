//
//  StatefulStatisticSectionView.swift
//  Twenty
//
//  Created by Hao Luo on 9/16/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

protocol StatisticSectionViewReader {
    var publisher: AnyPublisher<[StatisticCellComponent.Model], Never> { get }
}

final class StatisticSectionViewStore: StatisticSectionViewReader {
    
    init(
        goalPublisher: GoalPublisher,
        selectedDayPublisher: AnyPublisher<Date.Day, Never>
    ) {
        self.publisher = Publishers.CombineLatest(goalPublisher, selectedDayPublisher).map { (goal, selectedDay) -> [StatisticCellComponent.Model] in
            return [
                .init(
                    icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                    title: "\(goal.remainingTime(asOf: selectedDay).format(showSecond: false))",
                    subtitle: "To milestone"
                ),
                .init(
                    icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                    title: "\(goal.avgTimePerDay(asOf: selectedDay).format(showSecond: false))",
                    subtitle: "Avg everyday"
                ),
                .init(
                    icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                    title: "\(goal.recordsCount(asOf: selectedDay))",
                    subtitle: "Records count"
                ),
                .init(
                    icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                    title: "\(goal.streakCount(asOf: selectedDay))",
                    subtitle: "Streak"
                ),
            ]
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - StatisticSectionViewReader
    
    let publisher: AnyPublisher<[StatisticCellComponent.Model], Never>
}

struct StatefulStatisticSectionView: View {
    @ObservedObject private var viewReader: ObservableWrapper<[StatisticCellComponent.Model]>
    
    init(viewReader: ObservableWrapper<[StatisticCellComponent.Model]>) {
        self.viewReader = viewReader
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            StatisticSectionComponent(
                items: viewReader.value,
                rowCount: 2
            )
        } else {
            fatalError("< iOS 14 not supported")
        }
    }
}

struct StatefulStatisticSectionView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulStatisticSectionView(
            viewReader: .init(publisher: Just(Array(repeating: StatisticCellComponent.Model(
                icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                title: "1h 3m",
                subtitle: "subtitle"
            ), count: 4)).eraseToAnyPublisher())
        )
    }
}
