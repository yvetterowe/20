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
        ZStack(alignment: .topLeading){
            ColorManager.Blue.edgesIgnoringSafeArea(.all)
            VStack {
                    OnboardingTitleLabelComponent(title: "Let's get start")
                OnboardingTextFieldComponent(label: "First name", text: $firstName)
                    OnboardingTextFieldComponent(label: "Last name", text: $lastName)
                    OnboardingTextFieldComponent(label : "Email", text: $email)
                    OnboardingTextFieldComponent(label: "Password (8+ characters)", text: $password, image: "edit")
                Spacer()
                Button("Sign Up") {
                    store.signUpButtonTapped(
                        email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                        password: password.trimmingCharacters(in: .whitespacesAndNewlines),
                        firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
                        lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                }
                .buttonStyle(PrimaryTextButtonStyle())
                
            }.padding(20)
        }
        

    }
}

struct EmailSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView(store: .init(authService: NoOpAuthService()))
    }
}
