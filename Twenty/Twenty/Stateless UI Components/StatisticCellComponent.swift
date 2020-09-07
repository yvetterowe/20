//
//  StatisticCellComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct StatisticCellComponent: View {
    
    let model: Model
    struct Model {
        let icon: Image
        let title: String
        let subtitle: String
    }
    
    var body: some View {
        HStack {
            model.icon
            VStack(alignment: .leading) {
                Text(model.title)
                Text(model.subtitle)
            }
        }
    }
}

struct StatisticCellComponent_Previews: PreviewProvider {
    static var previews: some View {
        StatisticCellComponent(
            model: .init(
                icon: Image(systemName: "number.square"),
                title: "1h 15m",
                subtitle: "Avg everyday"
            )
        )
        .frame(width: 180, height: 40, alignment: .leading)
        .border(Color.red)
        
    }
}
