//
//  LoginPageView.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text(Constants.WelcomeString)
                    .font(.largeTitle)
                    .bold()
                
                Button {
                    path.append("login")
                } label: {
                    Text(Constants.LogInString)
                        .LogInButtonStyle()
                    
                }
                
                Button {
                    path.append("signup")
                } label: {
                    Text(Constants.SignUpString)
                        .LogInButtonStyle()
                }
                
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                    case "login":
                    LogInView(path: $path)
                case "signup":
                    SignUpView(path: $path)
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
