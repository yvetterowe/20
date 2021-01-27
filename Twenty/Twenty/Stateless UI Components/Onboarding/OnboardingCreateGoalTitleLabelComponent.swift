//
//  OnboardingCreateGoalTitleLabelComponent.swift
//  Twenty
//
//  Created by Hao Luo on 1/26/21.
//  Copyright © 2021 Hao Luo. All rights reserved.
//

import SwiftUI

struct OnboardingCreateGoalTitleLabelComponent: View {
    let title: String
    
    var body: some View {
        Text(title)
    }
}

struct OnboardingCreateGoalTitleLabelComponent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCreateGoalTitleLabelComponent(title: "Start with the first 20 hrs")
    }
}
