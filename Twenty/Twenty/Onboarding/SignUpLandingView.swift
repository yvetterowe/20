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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Learn Something new in 20hrs")
                    .font(.title)
                Text("Research shows...")
                    .font(.subheadline)
                NavigationLink(
                    destination: EmailSignUpView(),
                    isActive: $signUpButtonTapped
                ){
                    Button("Sign up") {
                        signUpButtonTapped = true
                    }
                }
                
                HStack {
                    Text("Already have an account?")
                    NavigationLink(
                        destination: EmailSignInView(),
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
        SignUpLandingView()
    }
}
