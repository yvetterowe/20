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
    
    func signUp(email: String, password: String, firstName: String?, lastName: String?) {
        let stateWriter = self.stateWriter
        firebaseAuth.createUser(withEmail: email, password: password) { (result, err) in
            if let err = err {
                stateWriter.update(.authenticateFailed(err))
            } else {
                //user was created successfully
                let db = Firestore.firestore()
                let userID = result!.user.uid
                db.collection("users").addDocument(data: ["firstName" : firstName, "lastName": lastName, "uid": userID ]){(err) in
                    if let err = err  {
                        stateWriter.update(.authenticateFailed(err))
                    } else {
                        stateWriter.update(.authenticated(userID))
                    }
                }
            }
        }
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
