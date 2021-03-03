//
//  GoalSummarySectionComponent.swift
//  Twenty
//
//  Created by Hao Luo on 9/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("VarelaRound-Regular", size: 18))

    }
}

extension View {
    func sectionTitleStyle() -> some View {
        self.modifier(SectionTitle())
    }
}



struct GoalSummarySectionComponent: View {
    let title: String
    let buttonAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .title2Text()
                .foregroundColor(ColorManager.DarkGray)
            Spacer()
            
            Button(action: buttonAction, label: {
                Image(uiImage: #imageLiteral(resourceName: "more-horizontal"))
                    .DarkIconImage()
            })
        }
    }
}

struct GoalSummarySectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        GoalSummarySectionComponent(title: "Learn SwiftUI", buttonAction: {})
    }
}
