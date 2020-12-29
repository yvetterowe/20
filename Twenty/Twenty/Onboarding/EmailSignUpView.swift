//
//  EmailSignUpView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

final class EmailSignUpStore {
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    func signUpButtonTapped(email: String, password: String, firstName: String?, lastName: String?) {
        authService.signUp(email: email, password: password, firstName: firstName, lastName: lastName )
    }
}

struct EmailSignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    let store: EmailSignUpStore
    
    var body: some View {
        VStack {
            OnboardingTitleLabelComponent(title: "Let's get started")
            Spacer()
            OnboardingTextFieldComponent(placeholder: "First name", text: $firstName)
            OnboardingTextFieldComponent(placeholder: "Last name", text: $lastName)
            OnboardingTextFieldComponent(placeholder: "Email", text: $email)
            OnboardingTextFieldComponent(placeholder: "Password (8+ characters)", text: $password)
            Button("Sign up") {
                store.signUpButtonTapped(
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                    password: password.trimmingCharacters(in: .whitespacesAndNewlines),
                    firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
                    lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines)
                )
            }
        }
        .padding(20)
        .background(ColorManager.Blue)
        .ignoresSafeArea(.all)
    }
}

struct EmailSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView(store: .init(authService: NoOpAuthService()))
    }
}
