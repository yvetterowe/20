//
//  AuthenticationService.swift
//  Twenty
//
//  Created by Hao Luo on 12/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

typealias UserID = String

enum AuthenticationState {
    case unauthenticated
    case authenticated(UserID)
    case authenticateFailed(Error)
}

protocol AuthenticationService {
    func signUp(email: String, password: String, firstName: String?, lastName: String?)
    func signIn(email: String, password: String)
    func signOut()
}

protocol AuthenticationStateReader {
    var authStatePublisher: AnyPublisher<AuthenticationState, Never> { get }
}

protocol AuthenticationStateWriter {
    func update(_ newState: AuthenticationState)
}
