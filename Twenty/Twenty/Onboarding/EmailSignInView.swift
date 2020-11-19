//
//  EmailSignInView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct EmailSignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            OnboardingTitleLabelComponent(title: "Welcome back")
            OnboardingTextFieldComponent(placeholder: "Email address", text: $email)
            OnboardingTextFieldComponent(placeholder: "Password", text: $password)
            Text("Forgot your password?")
            Button("Log in") {
                // TODO: firebase log in
            }
        }
    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignInView()
    }
}
