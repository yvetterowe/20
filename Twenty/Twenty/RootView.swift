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
    
    init(authStateStore: ObservableWrapper<AuthenticationState>) {
        self.authStateStore = authStateStore
    }
    
    var body: some View {
        switch authStateStore.value {
        case .unauthenticated:
            Text("Unknown user")
        case let .authenticated(userID):
            HomeWrapperView(userID: userID)
        case .none:
            fatalError("Invalid state")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(authStateStore: .init(publisher: Just(.unauthenticated).eraseToAnyPublisher()))
    }
}
