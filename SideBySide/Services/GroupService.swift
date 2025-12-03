//
//  GroupService.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-26.
//

import Foundation
import FirebaseFirestore

@MainActor
class GroupService {
    static let shared = GroupService()
    private init() {}

    let db = Firestore.firestore()

    // MARK: - Create Group
    func createGroup(ownerId: String, groupName: String) async throws -> String {
        let groupId = db.collection("groups").document().documentID
        let joinCode = try await generateUniqueJoinCode()
        
        let data: [String: Any] = [
            "name": groupName,
            "ownerId": ownerId,
            "joinCode": joinCode,
            "members": [ownerId],
            "createdAt": FieldValue.serverTimestamp()
        ]
        
        try await db.collection("groups").document(groupId).setData(data)
        
        return groupId
    }

    // MARK: - Join Group
    func joinGroup(code: String, userId: String) async throws -> String {
        let snapshot = try await db.collection("groups")
            .whereField("joinCode", isEqualTo: code)
            .limit(to: 1)
            .getDocuments()
        
        guard let document = snapshot.documents.first else {
            throw GroupError.groupNotFound
        }
        
        let groupId = document.documentID
        var members = document.get("members") as? [String] ?? []
        
        if members.contains(userId) {
            return groupId
        }
        
        members.append(userId)
        
        try await db.collection("groups")
            .document(groupId)
            .updateData([
                "members": members
            ])
        
        return groupId
    }

    // MARK: - Helpers: Generate Join Code
    private func generateJoinCode() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map { _ in letters.randomElement()! })
    }

    enum GroupError: LocalizedError {
        case groupNotFound
        
        var errorDescription: String? {
            switch self {
            case .groupNotFound:
                return "No group found with that code."
            }
        }
    }
    
    private func generateUniqueJoinCode() async throws -> String {
        var code = generateJoinCode()
        
        while try await joinCodeExists(code) {
            code = generateJoinCode()
        }
        return code
    }
    
    private func joinCodeExists(_ code: String) async throws -> Bool {
        let snapshot = try await db.collection("groups")
            .whereField("joinCode", isEqualTo: code)
            .getDocuments()
        
        return !snapshot.documents.isEmpty
    }
}
