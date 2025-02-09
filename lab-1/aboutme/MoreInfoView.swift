//
//  MoreInfoView.swift
//  aboutme
//
//  Created by Aknur Seidazym on 09.02.2025.
//

import SwiftUI

struct MoreInfoView: View {
    var body: some View {
        VStack {
            Text("I don't know what to write here.")
                .padding()
            Text("My favourite book:")
            HStack{
                Text("Унесенные психологией")
                Spacer()
                Text("Иман Қуанышқызы")
            }
            Image("book")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Центрирование
        }
        .padding()
    }
}

#Preview {
    MoreInfoView()
}
