//
//  OnboardingSubtitleLabelComponent.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct OnboardingSubtitleLabelComponent: View {
    let subtitle: String
    var body: some View {
        Text(subtitle)
            .font(Font.custom("VarelaRound-Regular", size: 16))
            .frame(maxWidth: .infinity, alignment:.leading)
            .foregroundColor(ColorManager.White)
    }
}

struct OnboardingSubtitleLabelComponent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSubtitleLabelComponent(subtitle: "subtitleeeeee")
    }
}
