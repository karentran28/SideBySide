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
    
    private var appVM: AppViewModel
    
    init() {
        FirebaseApp.configure()
        print("Firebase configure")
        appVM = AppViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(appVM)
        }
    }
}
