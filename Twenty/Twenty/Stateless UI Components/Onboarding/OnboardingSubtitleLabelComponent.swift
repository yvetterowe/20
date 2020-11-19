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
        Text(subtitle).font(.subheadline)
    }
}

struct OnboardingSubtitleLabelComponent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSubtitleLabelComponent(subtitle: "subtitleeeeee")
    }
}
