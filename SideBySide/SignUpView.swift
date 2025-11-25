//
//  SignInView.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import SwiftUI

struct SignUpView: View {
    @Binding var path: NavigationPath
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack{
            Text("Sign Up Now!")
                .font(.title2)
            TextField("Enter your email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)

            SecureField("Enter a password", text: $password)
                .padding(.leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            
            Button {
                print("Sign up info \(email), \(password)")
            } label: {
                Text("Sign Up")
                    .LogInButtonStyle()
            }
            .padding(.top)
            
            
            Button {
                path.append("login")
            } label: {
                Text("Already have an account? L og inhere.")
            }
                
        }
    }
}

// MARK: - Preview

struct SignUpView_Prefix: PreviewProvider {
    static var previews: some View {
        SignUpView(path: .constant(NavigationPath()))
    }
}
