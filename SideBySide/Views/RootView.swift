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
            if appVM.authUser == nil {
                WelcomeView()
            } else {
                HomeView()
            }
        }
    }
}

