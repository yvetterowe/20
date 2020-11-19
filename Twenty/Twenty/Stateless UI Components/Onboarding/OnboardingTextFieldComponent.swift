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
    
    var body: some View {
        TextField(placeholder, text: text)
    }
}

struct OnboardingTextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTextFieldComponent(placeholder: "Username", text: .constant("helloworld"))
    }
}
