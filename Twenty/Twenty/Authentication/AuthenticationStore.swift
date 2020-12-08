//
//  AuthenticationStore.swift
//  Twenty
//
//  Created by Hao Luo on 12/7/20.
//  Copyright © 2020 Hao Luo. All rights reserved.
//

import Combine

final class AuthenticationStore: AuthenticationStateReader, AuthenticationStateWriter {
    
    private let authStateSubject: CurrentValueSubject<AuthenticationState, Never>
    
    init() {
        self.authStateSubject = .init(.unauthenticated)
    }
    
    // MARK: - AuthenticationStateReader
    
    var authStatePublisher: AnyPublisher<AuthenticationState, Never> {
        return authStateSubject.eraseToAnyPublisher()
    }
    
    // MARK: - AuthenticationStateWriter
    
    func update(_ newState: AuthenticationState) {
        authStateSubject.send(newState)
    }
}
