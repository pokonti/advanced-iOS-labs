//
//  ViewModel.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 28.02.2025.
//

import Foundation

struct Hero: Decodable {
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

final class ViewModel: ObservableObject {
    @Published var selectedHero: Hero?

    // MARK: - Methods
    func fetchHero() async {
        guard
            let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json")
        else {
            return
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            let randomHero = heroes.randomElement()

            await MainActor.run {
                selectedHero = randomHero
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
}
