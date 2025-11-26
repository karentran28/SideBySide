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
                Text(Constants.welcomeString)
                    .font(.largeTitle)
                    .bold()
                
                Button {
                    path.append(Constants.pathLogInView)
                } label: {
                    Text(Constants.logInString)
                        .logInButtonStyle()
                    
                }
                
                Button {
                    path.append(Constants.pathSignInView)
                } label: {
                    Text(Constants.signUpString)
                        .logInButtonStyle()
                }
                
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                    case Constants.pathLogInView:
                    LogInView(path: $path)
                case Constants.pathSignInView:
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
