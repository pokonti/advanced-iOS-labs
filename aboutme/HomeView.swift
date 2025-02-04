//
//  HomeView.swift
//  aboutme
//
//  Created by Aknur Seidazym on 04.02.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.title)
            Text("My name is Aknur")
                .foregroundStyle(.indigo)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
