//
//  SetupView.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-11-25.
//

import SwiftUI
import PhotosUI

struct SetupView: View {
    @State var viewModel = SetupViewModel()
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @FocusState private var groupFieldFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                Text("Set up your profile")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                // MARK: - Profile Photo
                VStack(spacing: 12) {
                    if let image = viewModel.profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    PhotosPicker("Choose a Profile Photo", selection: $selectedPhotoItem, matching: .images)
                }
                .onChange(of: selectedPhotoItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            viewModel.profileImage = uiImage
                        }
                    }
                }
                
                TextField("Choose a username", text: $viewModel.username)
                    .emailTextFieldStyle()
                
                // MARK: - Group Choice Section
                VStack(spacing: 16) {
                    Text("Choose how you want to get started")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // CREATE GROUP option
                    GroupOptionCard(
                        title: "Create a Group",
                        description: "Start a new group for you and your friends",
                        selected: viewModel.groupChoice == .create
                    ) {
                        withAnimation(.easeInOut) {
                            viewModel.groupChoice = .create
                        }
                    }
                    
                    // JOIN GROUP option
                    GroupOptionCard(
                        title: "Join a Group",
                        description: "Enter a code to join an existing group",
                        selected: viewModel.groupChoice == .join
                    ) {
                        withAnimation(.easeInOut) {
                            viewModel.groupChoice = .join
                        }
                    }
                    
                    // SKIP option
                    GroupOptionCard(title: "Skip for now", description: "You can join a group later" , selected: viewModel.groupChoice == .skip) {
                        withAnimation(.easeInOut) {
                            viewModel.groupChoice = .skip
                            viewModel.groupName = ""
                            viewModel.groupCode = ""
                            groupFieldFocused = false
                        }
                    }
                    
                    // MARK: - Group input fields
                    if viewModel.groupChoice == .create {
                        TextField("Group name", text: $viewModel.groupName)
                            .emailTextFieldStyle()
                            .focused($groupFieldFocused)
                            .transition(.opacity)
                    }
                    
                    if viewModel.groupChoice == .join {
                        TextField("Enter group code", text: $viewModel.groupCode)
                            .emailTextFieldStyle()
                            .focused($groupFieldFocused)
                            .transition(.opacity)
                    }
                }
                
                Button {
                    Task { await viewModel.completeSetup() }
                } label: {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                
                
                // MARK: - Loading & Error
                if viewModel.isLoading {
                    ProgressView().padding(.top, 10)
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 6)
                }
            }
            .padding()
        }
    }
}

#Preview {
    SetupView()
}
