//
//  UserModel.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import Foundation
import FirebaseFirestore

struct AppUser: Identifiable, Codable {
    @DocumentID var id: String?
    let username: String
    let groupId: String?
    let streak: Int
    let onboardingCompleted: Bool
    let photoURL: String?
}
