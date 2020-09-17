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
    
    init(goalPublisher: GoalPublisher) {
        self.publisher = Just(Array(
            repeating: .init(
                icon: .init(systemName: "number.square"),
                title: "1h 3m",
                subtitle: "subtitle"
            ),
            count: 4
        )).eraseToAnyPublisher()
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

//struct StatefulStatisticSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatefulStatisticSectionView()
//    }
//}
