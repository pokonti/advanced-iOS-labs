//
//  UserProfile.swift
//  PleaseWorkPlease
//
//  Created by Aknur Seidazym on 19.02.2025.
//

import Foundation

struct UserProfile: Hashable {
    let id: String
    let username: String
    let bio: String
    let profileImageURL: URL?

    // Hash only immutable properties to ensure stable hash values
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // Equality based on unique ID
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        lhs.id == rhs.id
    }
}
