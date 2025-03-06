//
//  HeroDetailView.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 06.03.2025.
//

import SwiftUI

struct HeroDetailView: View {
    let hero: Hero
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isInFavorites: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                // Hero image
                AsyncImage(url: hero.imageUrl) { phase in
                    switch phase {
                    case .empty:
                        Color.teal
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        Color.red
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            )
                    @unknown default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .aspectRatio(2/3, contentMode: .fit)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Hero name and favorite button
                HStack {
                    Text(hero.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        toggleFavorite()
                    } label: {
                        Image(systemName: isInFavorites ? "heart.fill" : "heart")
                            .foregroundColor(isInFavorites ? .red : .white)
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                
                // Stats card
                VStack(alignment: .leading, spacing: 12) {
                    // Basic info section
                    Group {
                        if let fullName = hero.biography?.fullName, !fullName.isEmpty {
                            InfoRow(icon: "person.fill", title: "Full name", value: fullName)
                        }
                        
                        if let occupation = hero.work?.occupation, !occupation.isEmpty {
                            InfoRow(icon: "briefcase.fill", title: "Occupation", value: occupation)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        InfoRow(icon: "scale.3d", title: "Alignment", value: hero.biography?.alignment ?? "neutral")
                    }
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical, 8)
                    
                    // Appearance section
                    Group {
                        Text("Appearance")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if let gender = hero.appearance?.gender, !gender.isEmpty && gender != "null" {
                            InfoRow(icon: "person.crop.circle", title: "Gender", value: gender)
                        }
                        
                        if let race = hero.appearance?.race, !race.isEmpty && race != "null" {
                            InfoRow(icon: "person.fill.questionmark", title: "Race", value: race)
                        }
                        
                        if let height = hero.appearance?.height, !height.isEmpty {
                            InfoRow(icon: "ruler", title: "Height", value: height.joined(separator: " / "))
                        }
                        
                        if let weight = hero.appearance?.weight, !weight.isEmpty {
                            InfoRow(icon: "scalemass", title: "Weight", value: weight.joined(separator: " / "))
                        }
                        
                        if let eyeColor = hero.appearance?.eyeColor, !eyeColor.isEmpty && eyeColor != "null" {
                            InfoRow(icon: "eye", title: "Eye Color", value: eyeColor)
                        }
                        
                        if let hairColor = hero.appearance?.hairColor, !hairColor.isEmpty && hairColor != "null" {
                            InfoRow(icon: "scissors", title: "Hair Color", value: hairColor)
                        }
                    }
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical, 8)
                    
                    // Powerstats section
                    Group {
                        Text("Powerstats")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if let powerstats = hero.powerstats {
                            PowerStatBar(title: "Intelligence", value: powerstats.intelligence ?? 0, color: .blue)
                            PowerStatBar(title: "Strength", value: powerstats.strength ?? 0, color: .red)
                            PowerStatBar(title: "Speed", value: powerstats.speed ?? 0, color: .green)
                            PowerStatBar(title: "Durability", value: powerstats.durability ?? 0, color: .orange)
                            PowerStatBar(title: "Power", value: powerstats.power ?? 0, color: .purple)
                            PowerStatBar(title: "Combat", value: powerstats.combat ?? 0, color: .yellow)
                        }
                    }
                    
                    Divider()
                        .background(Color.gray)
                        .padding(.vertical, 8)
                    
                    // Biography section
                    Group {
                        Text("Biography")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if let placeOfBirth = hero.biography?.placeOfBirth, !placeOfBirth.isEmpty && placeOfBirth != "null" {
                            InfoRow(icon: "mappin.and.ellipse", title: "Place of Birth", value: placeOfBirth)
                        }
                        
                        if let firstAppearance = hero.biography?.firstAppearance, !firstAppearance.isEmpty && firstAppearance != "null" {
                            InfoRow(icon: "book.fill", title: "First Appearance", value: firstAppearance)
                        }
                        
                        if let aliases = hero.biography?.aliases, !aliases.isEmpty {
                            let aliasesText = aliases.joined(separator: ", ")
                            if !aliasesText.isEmpty {
                                InfoRow(icon: "person.text.rectangle", title: "Aliases", value: aliasesText)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .padding()
            }
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09019608051, green: 0.1019607857, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.1607843191, blue: 0.1921568662, alpha: 1))]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .onAppear {
            checkIfInFavorites()
        }
    }
    
    private func checkIfInFavorites() {
        isInFavorites = viewModel.favoriteHeroes.contains(where: { $0.id == hero.id })
    }
    
    private func toggleFavorite() {
        if isInFavorites {
            viewModel.removeFromFavorites(hero: hero)
        } else {
            viewModel.addToFavorites(hero: hero)
        }
        isInFavorites.toggle()
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .frame(width: 25)
                .foregroundColor(.gray)
            
            Text(title + ":")
                .fontWeight(.medium)
            
            Spacer(minLength: 4)
            
            Text(value)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
        }
        .foregroundColor(.white)
    }
}

struct PowerStatBar: View {
    let title: String
    let value: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("\(value)")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 8)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    
                    Rectangle()
                        .frame(width: min(CGFloat(value) / 100 * geometry.size.width, geometry.size.width), height: 8)
                        .foregroundColor(color)
                }
                .cornerRadius(4)
            }
            .frame(height: 8)
        }
    }
}
