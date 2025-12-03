//
//  AuthViewModel.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class AuthViewModel {
    
    var email = ""
    var password = ""
    var errorMessage = ""
    var isLoading = false
    
    func signUp() async {
        isLoading = true
        errorMessage = ""
        
        do {
            let result = try await FirebaseAuthService.shared.createUser(email: email, password: password)
            print("Successful sign up", result.user.uid)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func signIn() async {
        isLoading = true
        errorMessage = ""
        
        do {
            let result = try await FirebaseAuthService.shared.signIn(email: email, password: password)
            print("Successful sign in", result.user.uid)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
