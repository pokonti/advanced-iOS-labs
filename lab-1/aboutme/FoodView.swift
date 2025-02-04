//
//  FoodView.swift
//  aboutme
//
//  Created by Aknur Seidazym on 04.02.2025.
//

import SwiftUI

struct FoodView: View {
    var body: some View {
        HStack {
            ForEach(information.foods, id: \.self) { food in
                Text(food)
                    .font(.largeTitle)
            }
            .padding()
        }
    }
        
}

#Preview {
    FoodView()
}
