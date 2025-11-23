//
//  SideBySideApp.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-22.
//

import SwiftUI
import Firebase

@main
struct SideBySideApp: App {
    
    init() {
        FirebaseApp.configure()
        print("Firebase configured")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
