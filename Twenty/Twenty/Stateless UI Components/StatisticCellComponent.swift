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
                .resizable()
                .frame(width: 40, height: 40, alignment: .topLeading)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(Font.custom("VarelaRound-Regular", size: 16))
                    .foregroundColor(ColorManager.Blue)
                    .lineLimit(1)
                Text(model.subtitle)
                    .font(Font.custom("VarelaRound-Regular", size: 14))
                    .foregroundColor(ColorManager.MidGray)
                    .lineLimit(1)
                
                    
            }
        }
    }
}

struct StatisticCellComponent_Previews: PreviewProvider {
    static var previews: some View {
        StatisticCellComponent(
            model: .init(
                icon: Image("activity_icon"),
                title: "1h 15m",
                subtitle: "Avg everyday"
            )
        )
        .frame(width: 180, height: 40, alignment: .leading)
        .border(Color.red)
        
    }
}
