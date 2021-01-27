//
//  CreateGoalListComponent.swift
//  Twenty
//
//  Created by Hao Luo on 1/26/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct CreateGoalListComponent: View {
    let rows: [CreateGoalRowComponent.Model]
    
    var body: some View {
        List {
            ForEach(rows, id: \.self) { row in
                CreateGoalRowComponent(model: row)
            }
        }
    }
}

struct CreateGoalListComponent_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalListComponent(rows: [
            .init(emoji: "🏂", title: "snowboarding"),
            .init(emoji: "🏄🏻‍♀️", title: "surfing"),
            .init(emoji: "🤿", title: "diving"),
            .init(emoji: "🎸", title: "playing guitar"),
        ])
    }
}
