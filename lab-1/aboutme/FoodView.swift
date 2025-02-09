//
//  FoodView.swift
//  aboutme
//
//  Created by Aknur Seidazym on 04.02.2025.
//

import SwiftUI

struct FoodView: View {
    @State private var isVisible = false
    var body: some View {
        VStack {
            Text("What I like to eat:")
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        isVisible.toggle()
                    }
                }) {
                    ForEach(information.foods, id: \.self) { food in
                        Text(food)
                            .font(.largeTitle)
                        }
                    .scaleEffect(isVisible ? 2 : 0.5) // Увеличение
                    .animation(.easeInOut(duration: 1.0), value: isVisible)
                    .padding()
                }
            }
            .padding()
        }
        
    }
        
}

#Preview {
    FoodView()
}
