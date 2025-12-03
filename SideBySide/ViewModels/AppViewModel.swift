//
//  AppViewModel.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import FirebaseAuth
import FirebaseFirestore

@MainActor
@Observable
class AppViewModel {
    var authUser: FirebaseAuth.User?
    var appUser: AppUser?
    
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
            
            if let user = user {
                Task { await self?.loadUserDocument(uid: user.uid)}
            } else {
                self?.appUser = nil
            }
        }
    }
    
    func loadUserDocument(uid: String) async {
        do {
            let doc = try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .getDocument()
            
            if doc.exists {
                self.appUser = try doc.data(as: AppUser.self)
            } else {
                self.appUser = nil
            }
        } catch {
            print("Error loading user profile: \(error)")
        }
    }
    
    func reloadCurrentUser() async {
        guard let uid = authUser?.uid else { return }
        await loadUserDocument(uid: uid)
    }
    
    @MainActor
    deinit {
        // Clean up listener to avoid memory leaks
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
