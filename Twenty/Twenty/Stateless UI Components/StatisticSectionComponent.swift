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
        }.padding(.vertical, 16)
    }
}

struct StatisticSectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            StatisticSectionComponent(
                items: [
                    .init(
                        icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                        title: "0h 0m",
                        subtitle: "subtitle"
                    ),
                    .init(
                        icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                        title: "1",
                        subtitle: "short"
                    ),
                    .init(
                        icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                        title: "0h 0m",
                        subtitle: "lonnnnnnng"
                    ),
                    .init(
                        icon: .init(uiImage: #imageLiteral(resourceName: "activity_icon")),
                        title: "0h 0m",
                        subtitle: "avg"
                    ),
                ],
                rowCount: 2
            )
        } else {
            // Fallback on earlier versions
        }
    }
}
