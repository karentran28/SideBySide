//
//  Group.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-12-02.
//

import Foundation

struct Group: Identifiable, Codable {
    let id: String
    let name: String
    let ownerId: String
    let joinCode: String
    let members: [String]
    let createdAt: Date
}
