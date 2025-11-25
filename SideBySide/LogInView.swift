//
//  LogInView.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import SwiftUI

struct LogInView: View {
    @Binding var path: NavigationPath
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack{
            Text("Log in with your existing email")
                .font(.title2)
            TextField("Enter your email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)

            SecureField("Enter your password", text: $password)
                .padding(.leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Button {
                print("Log in info \(email), \(password)")
            } label: {
                Text("Log In")
                    .LogInButtonStyle()
            }
            .padding(.top)
            
            
            Button {
                path.append("signup")
            } label: {
                Text("Don't have an account? Sign up here.")
            }
                
        }
        .padding()
    }
}

// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(path: .constant(NavigationPath()))
    }
}
