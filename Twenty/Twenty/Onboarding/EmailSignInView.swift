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
            Text("Welcome back").font(.title)
            Text("TODO: sign in placeholder")
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
