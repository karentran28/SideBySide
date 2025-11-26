//
//  AppViewModel.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import FirebaseAuth

@MainActor
@Observable
class AppViewModel {
    var authUser: FirebaseAuth.User?
    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    
    init() {
        // test from welcome view
        try? Auth.auth().signOut()
        self.authUser = Auth.auth().currentUser
        listenToAuthChanges()
    }
    
    func listenToAuthChanges() {
        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.authUser = user
            
        }
    }
    
    @MainActor
    deinit {
        // Clean up listener to avoid memory leaks
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
