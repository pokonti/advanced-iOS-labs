//
//  Model.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 06.03.2025.
//
import Foundation

struct Hero: Decodable, Identifiable {
    let id: Int
    let name: String
    let images: Image
    let powerstats: powerstats?
    let appearance: Appearance?
    let biography: Biography?
    let work: Work?
    
    var imageUrl: URL? {
        URL(string: images.md)
    }
    

    struct Image: Decodable {
        let md: String
    }
    
    struct powerstats: Decodable {
       let intelligence: Int?
       let strength: Int?
       let speed: Int?
       let durability: Int?
       let power: Int?
       let combat: Int?
    }
    
    struct Biography: Decodable {
        let fullName: String?
        let aliases: [String]?
        let placeOfBirth: String?
        let firstAppearance: String?
        let publisher: String?
        let alignment: String?
    }
    
    struct Appearance: Decodable {
        let gender: String?
        let race: String?
        let height: [String]?
        let weight: [String]?
        let eyeColor: String?
        let hairColor: String?
    }
    
    struct Work: Decodable {
        let occupation: String
    }

}
