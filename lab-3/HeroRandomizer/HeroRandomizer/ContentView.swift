//
//  ContentView.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 28.02.2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var hasRolled = false // Флаг, чтобы скрыть текст до первого нажатия
    
    var body: some View {
        ZStack {
            LinearGradient(
                   gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09019608051, green: 0.1019607857, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.1607843191, blue: 0.1921568662, alpha: 1))]),
                   startPoint: .top,
                   endPoint: .bottom
               )
               .ignoresSafeArea()
            
            VStack {
                AsyncImage(url: viewModel.selectedHero?.imageUrl) { phase in
                    switch phase {
                    case .empty:
                        Color.teal
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(height: 300)
                    case .failure(let error):
                        Color.red
                            .frame(height: 300)
                    }
                }
                .padding(32)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        if let hero = viewModel.selectedHero, hasRolled {
                            Text(viewModel.selectedHero?.name ?? "")
                                .bold()
                                .font(.largeTitle)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Occupation: \(viewModel.selectedHero?.work?.occupation ?? "Unknown")")
                                .lineLimit(nil) // Allow unlimited lines
                                .multilineTextAlignment(.leading) // Align text properly
                                .fixedSize(horizontal: false, vertical: true) // Ensure text expands vertically
                               
                            Text("🧠 Intelligence: \(hero.powerstats?.intelligence ?? 0)")
                            Text("👤 Race: \(hero.appearance?.race ?? "Unknown")")
                            Text("👤 Gender: \(hero.appearance?.gender ?? "Unknown")")
                            Text("🧬 Race: \(hero.appearance?.race ?? "Unknown")")
                            
                            if let height = hero.appearance?.height, !height.isEmpty {
                                Text("📏 Height: \(height.joined(separator: " / "))")
                            }
                            
                            if let weight = hero.appearance?.weight, !weight.isEmpty {
                                Text("⚖️ Weight: \(weight.joined(separator: " / "))")
                            }
                            
                            Text("👁️ Eye Color: \(hero.appearance?.eyeColor ?? "Unknown")")
                            Text("💇 Hair Color: \(hero.appearance?.hairColor ?? "Unknown")")
                            
                            let alignment = hero.biography?.alignment?.lowercased() ?? "neutral"
                                            
                            let titleColor: Color = (alignment == "good") ? .green : (alignment == "bad") ? .red : .gray
                            
                            Text("⚖️ Alignment: \(hero.biography?.alignment ?? "neutral")")
                                .foregroundColor(titleColor)
                                
                        }
                       
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                }
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.fetchHero()
                        hasRolled = true // Показываем текст только после нажатия
                    }
                } label: {
                    HStack {
                        Image(systemName: "dice.fill")
                            .font(.system(size: 22, weight: .semibold))
                        
                        Text("Roll Hero")
                            .font(.system(size: 20, weight: .bold))
                    }
                    .foregroundStyle(.white)
                }
                
            }
        }
    }
}


#Preview {
    ContentView(viewModel: ViewModel())
}
