//
//  ContentView.swift
//  HeroRandomizer
//
//  Created by Aknur Seidazym on 28.02.2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var showingFavorites = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09019608051, green: 0.1019607857, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.1607843191, blue: 0.1921568662, alpha: 1))]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    if showingFavorites {
                        FavoritesView(viewModel: viewModel)
                    } else {
                        MainView(viewModel: viewModel)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showingFavorites.toggle()
                        } label: {
                            Image(systemName: showingFavorites ? "house.fill" : "heart.fill")
                                .foregroundColor(showingFavorites ? .white : .red)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView(viewModel: ViewModel())
}
