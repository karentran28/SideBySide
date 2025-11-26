//
//  FirebaseAuthService.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
    
    static let shared = FirebaseAuthService()
    
    private init() {}
    
    //Sign up
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    //Sign in
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
}
