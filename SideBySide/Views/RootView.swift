//
//  RootView.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import SwiftUI

struct RootView: View {
    @Environment(AppViewModel.self) var appVM
    
    var body: some View {
        Group {
            // Not logged in
            if appVM.authUser == nil {
                WelcomeView()
            //Logged in but no Firestore profile yet
            } else if appVM.appUser == nil {
                SetupView()
            } else if appVM.appUser?.onboardingCompleted == false {
                SetupView()
            } else {
                HomeView()
            }
        }
    }
}

