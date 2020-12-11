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
                        icon: .init("activity_icon"),
                        title: "1h 3m",
                        subtitle: "subtitle"
                    ),
                    .init(
                        icon: .init("activity_icon"),
                        title: "7",
                        subtitle: "short"
                    ),
                    .init(
                        icon: .init("activity_icon"),
                        title: "1h 3m",
                        subtitle: "lonnnnnnng"
                    ),
                    .init(
                        icon: .init("activity_icon"),
                        title: "looooooong",
                        subtitle: "avg"
                    ),
                ],
                rowCount: 2
            )
            .padding(.init(top: 16, leading: 20, bottom: 16, trailing: 20))
        } else {
            // Fallback on earlier versions
        }
    }
}
