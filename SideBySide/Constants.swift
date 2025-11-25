//
//  Constants.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import Foundation
import SwiftUI

struct Constants {
    static let WelcomeString = "Welcome to SideBySide"
    static let LogInString = "Log in"
    static let SignUpString = "Sign up"
    
    
}

extension Text {
    func LogInButtonStyle() -> some View {
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
