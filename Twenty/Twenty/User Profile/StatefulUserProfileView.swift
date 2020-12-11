//
//  StatefulUserProfileView.swift
//  Twenty
//
//  Created by Hao Luo on 12/10/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import SwiftUI

final class UserProfileViewStore {
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    func signOutButtonTapped() {
        authService.signOut()
    }
}

struct StatefulUserProfileView: View {
    let store: UserProfileViewStore
    var body: some View {
        UserProfileComponent {
            self.store.signOutButtonTapped()
        }
    }
}

struct StatefulUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulUserProfileView(store: .init(authService: NoOpAuthService()))
    }
}
