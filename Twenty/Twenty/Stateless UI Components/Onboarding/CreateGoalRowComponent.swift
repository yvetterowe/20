//
//  CreateGoalRowComponent.swift
//  Twenty
//
//  Created by Hao Luo on 1/26/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct CreateGoalRowComponent: View {
    
    let model: Model
    struct Model: Hashable {
        let emoji: String
        let title: String
    }
    
    var body: some View {
        HStack {
            Text(model.emoji)
            Text(model.title)
        }
    }
}

struct CreateGoalRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        CreateGoalRowComponent(model: .init(emoji: "🏂", title: "snowboarding"))
    }
}
