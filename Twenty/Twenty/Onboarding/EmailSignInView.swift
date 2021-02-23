//
//  EmailSignInView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI


final class EmailSignInStore {
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    func signInButtonTapped(email: String, password: String) {
        authService.signIn(email: email, password: password)
    }
}

struct EmailSignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    let store: EmailSignInStore
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ColorManager.Blue.edgesIgnoringSafeArea(.all)
            VStack{
                OnboardingTitleLabelComponent(title: "Welcome back")
                OnboardingTextFieldComponent(label: "Email address", text: $email, image: "edit")
                OnboardingTextFieldComponent(label: "Password", text: $password, image: "edit")
                Text("Forgot your password?")
                Button("Log in") {
                    store.signInButtonTapped(
                        email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                        password: password.trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                }
                .buttonStyle(PrimaryTextButtonStyle())
            }
            .padding(20)
        }

    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignInView(store: .init(authService: NoOpAuthService()))
    }
}
