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
            .font(.custom("VarelaRound-Regular", size: 18))
            .multilineTextAlignment(.leading)
            .foregroundColor(ColorManager.White).opacity(0.6)
            .lineSpacing(4)
            

    }
}

struct OnboardingSubtitleLabelComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ColorManager.Blue.edgesIgnoringSafeArea(.all)
            OnboardingSubtitleLabelComponent(subtitle: "That learning curve differs immensely between various skills but Kauffman found that most skills can be acquired, at least at a basic level of proficiency, within just 20 hours. Just 20 hours of deliberate, focused practise is all you really need to build basic proficiency in any new skill.")
        }
            
        }

}
