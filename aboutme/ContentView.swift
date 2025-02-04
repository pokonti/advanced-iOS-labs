//
//  ContentView.swift
//  aboutme
//
//  Created by Aknur Seidazym on 04.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "person")
                       
                }
            FoggyFutureView()
                .tabItem {
                    Label("Foggy Future", systemImage: "cloud.fog.fill")
                }
            FoodView()
                .tabItem {
                    Label("Food", systemImage: "takeoutbag.and.cup.and.straw")
                }
        }
    }
}

#Preview {
    ContentView()
}
