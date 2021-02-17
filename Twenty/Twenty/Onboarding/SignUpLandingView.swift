//
//  SignUpLandingView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct SignUpLandingView: View {
    @State private var signUpButtonTapped = false
    @State private var signInButtonTapped = false
    
    let authService: AuthenticationService
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading){
                ColorManager.Blue.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20){
                    HStack{
                        Text("TWENTY")
                            .foregroundColor(ColorManager.White)
                    }
                    OnboardingTitleLabelComponent(title: "Learn something new in 20hrs")
                    OnboardingSubtitleLabelComponent(subtitle: "That learning curve differs immensely between various skills but Kauffman found that most skills can be acquired, at least at a basic level of proficiency, within just 20 hours. Just 20 hours of deliberate, focused practise is all you really need to build basic proficiency in any new skill.")
                    
                    NavigationLink(
                        destination: EmailSignUpView(store: .init(authService: authService)),
                        isActive: $signUpButtonTapped
                    ){
                        Button("Sign up") {
                            signUpButtonTapped = true
                        }
                    }
                    HStack {
                        OnboardingSubtitleLabelComponent(subtitle: "Already have an account?")
                        NavigationLink(
                            destination: EmailSignInView(store: .init(authService: authService)),
                            isActive: $signInButtonTapped
                        ){
                            Button("Sign in") {
                                signInButtonTapped = true
                            }
                            .foregroundColor(ColorManager.White)
                            
                        }
                    }
                }
                .padding(20)
            }
        }
    }
}

struct SignUpLandingView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpLandingView(authService: NoOpAuthService())
    }
}
