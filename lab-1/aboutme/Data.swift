//
//  Data.swift
//  aboutme
//
//  Created by Aknur Seidazym on 04.02.2025.
//

import Foundation

struct Info {
    let favouriteSubjects: [String: String]
    let hobbies: [String]
    let foods: [String]
}


let information = Info(
    favouriteSubjects: ["Backend Dev":"backend", "iOS Dev": "ios", "Computer Vision": "cv"],
    hobbies: ["dance", "playing guitar", "learning japanese"],
    foods: ["🌽", "🥒", "🍔"]
)
