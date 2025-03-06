//
//  MainView.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 06.03.2025.
//
import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            if let hero = viewModel.selectedHero {
                NavigationLink(destination: HeroDetailView(hero: hero, viewModel: viewModel)) {
                    AsyncImage(url: hero.imageUrl) { phase in
                        switch phase {
                        case .empty:
                            Color.teal
                                .frame(height: 400)
                                .cornerRadius(12)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 400)
                                .cornerRadius(12)
                                .clipped()
                        case .failure:
                            Color.red
                                .frame(height: 400)
                                .cornerRadius(12)
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
                }
            } else {
                Color.teal
                    .frame(height: 300)
                    .cornerRadius(12)
                    .padding(.horizontal, 32)
            }

            if let hero = viewModel.selectedHero {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(hero.name)
                            .bold()
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .center)

                        if let occupation = hero.work?.occupation, !occupation.isEmpty {
                            Text("Occupation: \(occupation)")
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        if let intelligence = hero.powerstats?.intelligence {
                            Text("🧠 Intelligence: \(intelligence)")
                        }

                        if let race = hero.appearance?.race, !race.isEmpty && race != "null" {
                            Text("👤 Race: \(race)")
                        }

                        if let gender = hero.appearance?.gender, !gender.isEmpty && gender != "null" {
                            Text("👤 Gender: \(gender)")
                        }

                        let alignment = hero.biography?.alignment?.lowercased() ?? "neutral"
                        let titleColor: Color = (alignment == "good") ? .green : (alignment == "bad") ? .red : .gray

                        Text("⚖️ Alignment: \(hero.biography?.alignment ?? "neutral")")
                            .foregroundColor(titleColor)
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                }
            }

            Spacer()

            Button {
                Task {
                    await viewModel.fetchHero()
                }
            } label: {
                HStack {
                    Image(systemName: "dice.fill")
                        .font(.system(size: 22, weight: .semibold))

                    Text("Roll Hero")
                        .font(.system(size: 20, weight: .bold))
                }
                .padding()
                .background(Color(UIColor.systemGray6).opacity(0.2))
                .foregroundStyle(.white)
                .cornerRadius(10)
            }
            .padding(.bottom)
        }
    }
}
