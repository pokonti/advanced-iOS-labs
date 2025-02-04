//
//  FoggyFutureView.swift
//  aboutme
//
//  Created by Aknur Seidazym on 04.02.2025.
//

import SwiftUI

struct FoggyFutureView: View {
    var body: some View {
        VStack {
            ForEach(information.favouriteSubjects.keys.sorted(), id: \.self) { name in
                Text(name)
                    .font(.title)
                if let imageName = information.favouriteSubjects[name] {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                Divider()
                }
            }
        }

    }
}

#Preview {
    FoggyFutureView()
}
