//
//  LogInView.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import SwiftUI

struct LogInView: View {
    @Binding var path: NavigationPath
    @State var viewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text(Constants.logInExistingEmailString)
                    .font(.title2)
                TextField(Constants.emailTextFieldString, text: $viewModel.email)
                    .emailTextFieldStyle()
                    .disabled(viewModel.isLoading)

                SecureField(Constants.passwordTextFieldString, text: $viewModel.password)
                    .passwordTextFieldStyle()
                    .disabled(viewModel.isLoading)
                
                //Error msg
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    Task {
                        await viewModel.signIn()
                    }
                } label: {
                    Text(Constants.logInString)
                        .logInButtonStyle()
                }
                .padding(.top)
                .disabled(viewModel.isLoading)
                
                Button {
                    path.append(Constants.pathSignInView)
                } label: {
                    Text(Constants.signUpHereString)
                }
                .disabled(viewModel.isLoading)
                    
            }
            .padding()
            
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.clear)           }
        }
    }
}

// MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(path: .constant(NavigationPath()))
    }
}
