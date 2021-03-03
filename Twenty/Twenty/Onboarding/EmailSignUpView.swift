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
    @State var isFocused = false


    
    let store: EmailSignUpStore
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ColorManager.Blue.edgesIgnoringSafeArea(.all)
            VStack {

                Text("Let's get start").headerText()
                VStack(alignment: .leading){
                    LightTextFieldComponent(label: "First name", text: $firstName)
                    LightTextFieldComponent(label: "Last name", text: $lastName)
                    LightTextFieldComponent(label : "Email", text: $email)
                    LightSecureFieldComponent(label: "Password (8+ characters)", text: $password, image: "edit")
                    if errorMessage != "" {
                        Text(errorMessage).errorText()
                    }
                }
                .onTapGesture {
                    self.isFocused = true
                }

                Button("Sign Up") {
                    store.signUpButtonTapped(
                        email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                        password: password.trimmingCharacters(in: .whitespacesAndNewlines),
                        firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
                        lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines)
                    )
                }
                .buttonStyle(LightPrimaryTextButtonStyle())
                
                HStack(spacing: 0){
                    Text("By continuing, you agree to Twenty’s Terms & Conditions ").helperText()

                }
                
            }.padding(20)
            .offset(y: isFocused ? -56 : 0)
            .animation(isFocused ? .timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8) : .none)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            
        }
        

    }
}

struct EmailSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignUpView(store: .init(authService: NoOpAuthService()))
            .previewDevice("iPhone 11 Pro")
    }
}
