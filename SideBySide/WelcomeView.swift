//
//  LoginPageView.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import SwiftUI

struct LoginPageView: View {
    var body: some View {
        VStack {
            Text(Constants.WelcomeString)
                .font(.largeTitle)
                .bold()
            
            Button {
                
            } label: {
                Text(Constants.LogInString)
                    .LogInButtonStyle()

            }
                        
            Button {
                
            } label: {
                Text(Constants.SignUpString)
                    .LogInButtonStyle()
            }
            
        }
    }
}

#Preview {
    LoginPageView()
}
