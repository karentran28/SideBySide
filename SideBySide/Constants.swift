//
//  Constants.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import Foundation
import SwiftUI

struct Constants {
    static let welcomeString = "Welcome to SideBySide"
    static let logInString = "Log in"
    static let signUpString = "Sign up"
    static let signUpNowString = "Sign Up Now!"
    static let logInExistingEmailString = "Log in with an existing email"
    static let emailTextFieldString = "Enter your email"
    static let passwordTextFieldString = "Enter your password"
    static let signUpHereString = "Don't have an account? Sign up here."
    static let logInHereString = "Already have an account? Log in here."
    
    static let pathSignInView = "signup"
    static let pathLogInView = "login"
    
}

extension Text {
    func logInButtonStyle() -> some View {
        self
            .font(.title3)
            .frame(width: 200, height: 40)
            .foregroundStyle(.D_1)
            .bold()
            .background{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.C_2, lineWidth: 5)
            }
    }
}

extension TextField {
    func emailTextFieldStyle() -> some View {
        self
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}

extension SecureField {
    func passwordTextFieldStyle() -> some View {
        self
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}


