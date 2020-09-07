//
//  DayViewHeaderComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct DayViewHeaderComponent: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Text(title)
            Text(subtitle)
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
