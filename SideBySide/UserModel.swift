//
//  UserModel.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-24.
//

import Foundation

struct User: Identifiable {
    let id: String
    let name: String
    let groupId: String?
    let streak: Int
}
