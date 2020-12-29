//
//  OnboardingTitleLabelComponent.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct OnboardingTitleLabelComponent: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(Font.custom("VarelaRound-Regular", size: 40))
            .frame(maxWidth: .infinity, alignment:.leading)
            .foregroundColor(ColorManager.White)
    }
}

struct OnboardingTitleLabelComponent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTitleLabelComponent(title: "Let's get started")
    }
}
