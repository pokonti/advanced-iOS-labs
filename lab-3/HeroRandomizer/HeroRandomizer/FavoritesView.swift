//
//  FavoritesView.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 06.03.2025.
//
import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if viewModel.favoriteHeroes.isEmpty {
                    VStack {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding(.top, 100)
                            .padding(.bottom, 20)
                        
                        Text("No favorite heroes yet")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                } else {
                    ForEach(viewModel.favoriteHeroes) { hero in
                        NavigationLink(destination: HeroDetailView(hero: hero, viewModel: viewModel)) {
                            favoriteRow(hero: hero)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func favoriteRow(hero: Hero) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                if let alignment = hero.biography?.alignment, !alignment.isEmpty {
                    let alignmentColor: Color = (alignment.lowercased() == "good") ? .green :
                                              (alignment.lowercased() == "bad") ? .red : .gray
                    
                Text(hero.name)
                    .font(.headline)
                    .foregroundColor(alignmentColor)
                        
                }
            }
            
            Spacer()
            
            Button {
                viewModel.removeFromFavorites(hero: hero)
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.title3)
            }
            .padding(.trailing, 8)
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.systemGray6).opacity(0.2))
        .cornerRadius(12)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: ViewModel())
    }
}
