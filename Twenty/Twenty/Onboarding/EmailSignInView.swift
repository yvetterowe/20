//
//  EmailSignInView.swift
//  Twenty
//
//  Created by Hao Luo on 11/18/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

struct EmailSignInView: View {
    var body: some View {
        VStack {
            OnboardingTitleLabelComponent(title: "Welcome back")
            
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
