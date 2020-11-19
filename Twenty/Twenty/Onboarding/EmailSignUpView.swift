//
//  EmailSignUpView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct EmailSignUpView: View {
    var body: some View {
        VStack {
            OnboardingTitleLabelComponent(title: "Let's get started")
            Text("TODO: Email sign up placeholder")
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
