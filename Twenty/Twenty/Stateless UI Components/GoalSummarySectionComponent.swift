//
//  GoalSummarySectionComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct GoalSummarySectionComponent: View {
    let title: String
    let buttonAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button(action: buttonAction) {
                Image(systemName: "ellipsis")
            }
        }
    }
}

struct GoalSummarySectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        GoalSummarySectionComponent(title: "Learn SwiftUI", buttonAction: {})
    }
}
