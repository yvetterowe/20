//
//  AuthenticationServiceImpl.swift
//  Twenty
//
//  Created by Hao Luo on 12/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Firebase

final class FirebaseAuthenticationService: AuthenticationService {
    private let stateWriter: AuthenticationStateWriter
    private let firebaseAuth: Auth
    
    init(firebaseAuth: Auth, stateWriter: AuthenticationStateWriter) {
        self.firebaseAuth = firebaseAuth
        self.stateWriter = stateWriter
        
        if let userID = firebaseAuth.currentUser?.uid {
            stateWriter.update(.authenticated(userID))
        } else {
            stateWriter.update(.unauthenticated)
        }
    }
    
    // MARK: - AuthenticationService
    
    func signUp(email: String, password: String) {
        stateWriter.update(.unauthenticated)
    }
    
    func signIn(email: String, password: String) {
        stateWriter.update(.unauthenticated)
    }
    
    func signOut() {
         // TODO
    }
}
