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
        let stateWriter = self.stateWriter
        firebaseAuth.signIn(withEmail: email, password:password){(result, err) in
            if let err = err {
                stateWriter.update(.authenticateFailed(err))
            } else{
                guard let userID = result?.user.uid else {
                    fatalError("No userID")
                }
                
                stateWriter.update(.authenticated(userID))
            }
        }
    }
    
    func signOut() {
         // TODO
    }
}
