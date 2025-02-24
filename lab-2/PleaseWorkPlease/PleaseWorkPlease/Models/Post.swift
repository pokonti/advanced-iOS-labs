//
//  Post.swift
//  PleaseWorkPlease
//
//  Created by Aknur Seidazym on 19.02.2025.
//

import Foundation

struct Post: Hashable {
    let id: UUID
    let author: UserProfile
    let hashtags: [String]
    var content: String
    

    // Hashing only immutable properties ensures consistency
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // Posts are equal if their unique IDs match
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}
