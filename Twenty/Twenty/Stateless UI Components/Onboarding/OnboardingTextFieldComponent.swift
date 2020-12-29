//
//  OnboardingTextFieldComponent.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct OnboardingTextFieldComponent: View {
    let placeholder: String
    let text: Binding<String>
    @State private var isEditing = false
    
    var body: some View {
        TextField(placeholder, text: text)
        { isEditing in
                self.isEditing = isEditing
            }
        .foregroundColor(isEditing ? ColorManager.White : ColorManager.MidGray)
        .font(Font.custom("VarelaRound-Regular", size: 18))
        .frame(height: 56, alignment: .leading)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
        
    }
}

struct OnboardingTextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTextFieldComponent(placeholder: "Username", text: .constant("Name"))
    }
}
