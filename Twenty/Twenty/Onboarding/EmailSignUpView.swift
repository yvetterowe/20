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
    @State private var errorMessage: String = ""


    
    let store: EmailSignUpStore
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ColorManager.Blue.edgesIgnoringSafeArea(.all)
            VStack {

                Text("Let's get start").headerText()
                VStack(alignment: .leading){
                    OnboardingTextFieldComponent(label: "First name", text: $firstName)
                    OnboardingTextFieldComponent(label: "Last name", text: $lastName)
                    OnboardingTextFieldComponent(label : "Email", text: $email)
                    OnboardingTextFieldComponent(label: "Password (8+ characters)", text: $password, image: "edit")
                    if errorMessage != "" {
                        Text(errorMessage).errorText()
                    }
                }

                Button("Sign Up") {
                    store.signUpButtonTapped(
                        email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                        password: password.trimmingCharacters(in: .whitespacesAndNewlines),
                        firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
                        lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                }
                .buttonStyle(PrimaryTextButtonStyle())
                
                VStack{
                    Text("By continuing, you agree to Twenty’s ").helperText()
                    Link("Terms & Conditions",
                         destination: URL(string: "https://www.example.com/TOS.html")!).foregroundColor(ColorManager.LightPink)
                    Text(" and ").helperText()
                    Link("Privacy Policy",
                         destination: URL(string: "https://www.example.com/TOS.html")!)
                        .foregroundColor(ColorManager.LightPink)
                }
            }.padding(20)
            
        }
        

    }
}

struct EmailSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView(store: .init(authService: NoOpAuthService()))
    }
}
