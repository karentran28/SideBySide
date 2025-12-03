//
//  SetupViewModel.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

@MainActor
@Observable
class SetupViewModel {
    
    // User input
    var username: String = ""
    var profileImage: UIImage? = nil
    var groupChoice: GroupChoice = .skip
    var groupName: String = ""
    var groupCode: String = ""
    
    // State
    var isLoading: Bool = false
    var errorMessage: String = ""
    var onboardingFinished = false
    
    enum GroupChoice {
        case join
        case create
        case skip
    }
    
    func completeSetup() async {
        isLoading = true
        errorMessage = ""
        
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "User not logged in"
            isLoading = false
            return
        }
        
        do {
            let photoURL = try await uploadProfilePhotoIfNeeded(uid: uid)
            
            let groupId = try await handleGroupChoice(uid: uid)
            
            // nil if user skipped
            let finalGroupId = groupChoice == .skip ? nil : groupId
            
            try await saveUserDocument(uid: uid, username: username, groupId: finalGroupId, photoURL: photoURL)
            
            self.onboardingFinished = true

        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func uploadProfilePhotoIfNeeded(uid: String) async throws -> String? {
        guard let image = profileImage else {
            return nil
        }
        
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        let storageRef = Storage.storage().reference().child("profileImages/\(uid).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = try await storageRef.putDataAsync(data, metadata: metadata)
        let url = try await storageRef.downloadURL()
        return url.absoluteString
    }
    
    func handleGroupChoice(uid: String) async throws -> String? {
        switch groupChoice {
        case .skip:
            return nil
        case .create:
            return try await GroupService.shared.createGroup(ownerId: uid, groupName: groupName)
        case .join:
            return try await GroupService.shared.joinGroup(code: groupCode, userId: uid)
        }
    }
    
    func saveUserDocument(uid: String, username: String, groupId: String?, photoURL: String?) async throws {
        
        var data: [String: Any] = [
            "username": username,
            "groupId": groupId as Any,
            "streak": 0,
            "onboardingCompleted": true
        ]

        if let url = photoURL {
            data["photoURL"] = url
        }

        try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData(data, merge: true)
    }
}
