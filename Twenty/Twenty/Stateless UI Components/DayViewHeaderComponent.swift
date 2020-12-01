//
//  DayViewHeaderComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct Header: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("VarelaRound-Regular", size: 24))
            
    }
}

extension View {
    func headerStyle() -> some View {
        self.modifier(Header())
    }
}

struct DayViewHeaderComponent: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Text(title)
                .headerStyle()
                .foregroundColor(ColorManager.DarkGray)
            Text(subtitle)
                .headerStyle()
                .foregroundColor(ColorManager.MidGray)
        }
    }
}

struct DayViewHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        DayViewHeaderComponent(
            title: "Today",
            subtitle: "Jul 24"
        )
    }
}
