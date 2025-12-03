//
//  GroupOptionCard.swift
//  SideBySide
//
//  Created by Karen Tran on 2025-12-02.
//

import SwiftUI

struct GroupOptionCard: View {
    let title: String
    let description: String
    let selected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(selected ? Color.blue.opacity(0.08) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selected ? Color.blue : Color.gray.opacity(0.3),
                            lineWidth: selected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        GroupOptionCard(
            title: "Create a Group",
            description: "Start a new group for your friends",
            selected: true,
            action: {}
        )
        
        GroupOptionCard(
            title: "Join a Group",
            description: "Enter a group code",
            selected: false,
            action: {}
        )
    }
    .padding()
}
