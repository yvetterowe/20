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
            VStack {
                OnboardingTitleLabelComponent(title: "Learn Something new in 20hrs")
                OnboardingSubtitleLabelComponent(subtitle: "Research shows...")
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
                    }
                }
            }
        }
    }
}

struct SignUpLandingView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpLandingView(authService: NoOpAuthService())
    }
}
