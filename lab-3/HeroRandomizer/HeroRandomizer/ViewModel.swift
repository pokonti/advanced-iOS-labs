//
//  ViewModel.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 28.02.2025.
//

import Foundation
import UIKit

final class ViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedHero: Hero?
    @Published var allHeroes: [Hero] = []
    @Published var favoriteHeroes: [Hero] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Methods
//    func fetchHero() async {
//        guard
//            let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json")
//        else {
//            return
//        }
//
//        let urlRequest = URLRequest(url: url)
//
//        do {
//            let (data, _) = try await URLSession.shared.data(for: urlRequest)
//            let heroes = try JSONDecoder().decode([Hero].self, from: data)
//            let randomHero = heroes.randomElement()
//
//            await MainActor.run {
//                selectedHero = randomHero
//            }
//        }
//        catch {
//            print("Error: \(error)")
//        }
//    }
    
    /// Fetches all heroes from the API
    func fetchAllHeroes() async throws {
        guard let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json") else {
            throw NSError(domain: "HeroRandomizer", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "HeroRandomizer", code: 2, userInfo: [NSLocalizedDescriptionKey: "Server error"])
        }
        
        let heroes = try JSONDecoder().decode([Hero].self, from: data)
        
        await MainActor.run {
            allHeroes = heroes
        }
    }
    
    /// Fetches a random hero and updates the selected hero
       func fetchHero() async {
           await MainActor.run {
               isLoading = true
               errorMessage = nil
           }
           
           do {
               if allHeroes.isEmpty {
                   try await fetchAllHeroes()
               }
               
               guard !allHeroes.isEmpty else {
                   throw NSError(domain: "HeroRandomizer", code: 1, userInfo: [NSLocalizedDescriptionKey: "No heroes available"])
               }
               
               await MainActor.run {
                   selectedHero = allHeroes.randomElement()
                   isLoading = false
               }
           } catch {
               await MainActor.run {
                   errorMessage = error.localizedDescription
                   isLoading = false
               }
           }
       }
       
    
    // MARK: - Initialization
        init() {
            loadFavorites()
        }
        
        /// Saves favorites to UserDefaults
        private func saveFavorites() {
            if let encoded = try? JSONEncoder().encode(favoriteHeroes.map { $0.id }) {
                UserDefaults.standard.set(encoded, forKey: "FavoriteHeroes")
            }
        }
        /// Adds a hero to favorites
        func addToFavorites(hero: Hero) {
            guard !favoriteHeroes.contains(where: { $0.id == hero.id }) else { return }
            
            favoriteHeroes.append(hero)
            saveFavorites()
        }
        
        /// Removes a hero from favorites
        func removeFromFavorites(hero: Hero) {
            favoriteHeroes.removeAll(where: { $0.id == hero.id })
            saveFavorites()
        }
        
        /// Loads favorites from UserDefaults
        private func loadFavorites() {
            guard let savedData = UserDefaults.standard.data(forKey: "FavoriteHeroes"),
                  let savedIds = try? JSONDecoder().decode([Int].self, from: savedData) else {
                return
            }
            
            Task {
                try? await fetchAllHeroes()
                
                let favorites = allHeroes.filter { savedIds.contains($0.id) }
                
                await MainActor.run {
                    self.favoriteHeroes = favorites
                }
            }
        }
}
