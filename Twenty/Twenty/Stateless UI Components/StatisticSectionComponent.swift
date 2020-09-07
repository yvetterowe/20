//
//  StatisticSectionComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct StatisticSectionComponent: View {
    let items: [StatisticCellComponent.Model]
    let rowCount: Int
    
    private let gridLayout: GridItem = GridItem(.flexible(), alignment: .leading)
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: gridLayout, count: rowCount), alignment: .leading) {
            ForEach(0..<items.count) { itemIndex in
                StatisticCellComponent(
                    model: items[itemIndex]
                )
            }
        }
    }
}

struct StatisticSectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            StatisticSectionComponent(
                items: [
                    .init(
                        icon: .init(systemName: "number.square"),
                        title: "1h 3m",
                        subtitle: "subtitle"
                    ),
                    .init(
                        icon: .init(systemName: "number.square"),
                        title: "7",
                        subtitle: "short"
                    ),
                    .init(
                        icon: .init(systemName: "number.square"),
                        title: "1h 3m",
                        subtitle: "lonnnnnnng"
                    ),
                    .init(
                        icon: .init(systemName: "number.square"),
                        title: "looooooong",
                        subtitle: "avg"
                    ),
                ],
                rowCount: 2
            ).frame(width: 312.0).border(Color.red)
        } else {
            // Fallback on earlier versions
        }
    }
}
