//
//  EmailSignUpView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct EmailSignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            OnboardingTitleLabelComponent(title: "Let's get started")
            OnboardingTextFieldComponent(placeholder: "First name", text: $firstName)
            OnboardingTextFieldComponent(placeholder: "Last name", text: $lastName)
            OnboardingTextFieldComponent(placeholder: "Email", text: $email)
            OnboardingTextFieldComponent(placeholder: "Password (8+ characters)", text: $password)
            Button("Sign up") {
                // TODO: firebase email sign up
            }
        }
    }
}

struct EmailSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView()
    }
}
