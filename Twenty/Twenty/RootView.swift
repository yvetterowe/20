//
//  RootView.swift
//  Twenty
//
//  Created by Hao Luo on 12/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine
import SwiftUI

struct RootView: View {
    @ObservedObject private var authStateStore: ObservableWrapper<AuthenticationState>
    private let authService: AuthenticationService
    
    init(
        authStateStore: ObservableWrapper<AuthenticationState>,
        authService: AuthenticationService
    ) {
        self.authStateStore = authStateStore
        self.authService = authService
    }
    
    var body: some View {
        switch authStateStore.value {
        case .unauthenticated:
            SignUpLandingView(authService: authService)
        case let .authenticated(userID):
            HomeWrapperView(userID: userID, authService: authService)
        case .authenticateFailed:
            VStack {
                SignUpLandingView(authService: authService)
                Text("Auth failed placeholder")
            }
        case .none:
            fatalError("Invalid state")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            authStateStore: .init(publisher: Just(.unauthenticated).eraseToAnyPublisher()),
            authService: NoOpAuthService()
        )
    }
}
