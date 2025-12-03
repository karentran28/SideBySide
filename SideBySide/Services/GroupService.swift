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
        
        let joinCode = generateJoinCode()
        
        let data: [String: Any] = [
            "groupId": groupId,
            "ownerId": ownerId,
            "groupName": groupName,
            "joinCode": joinCode,
            "createdAt": Date()
        ]
        
        try await db.collection("groups").document(groupId).setData(data)
        
        return groupId
    }

    // MARK: - Join Group
    func joinGroup(code: String, userId: String) async throws -> String {
        let snapshot = try await db.collection("groups")
            .whereField("joinCode", isEqualTo: code)
            .getDocuments()
        
        guard let document = snapshot.documents.first else {
            throw GroupError.groupNotFound
        }
        
        let groupId = document.documentID
        
        return groupId
    }

    // MARK: - Helper: Generate Join Code
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
}
