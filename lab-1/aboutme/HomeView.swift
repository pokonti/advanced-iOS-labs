//
//  HomeView.swift
//  aboutme
//
//  Created by Aknur Seidazym on 04.02.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Text("Hello, world!")
                    .font(Font.custom("LavishlyYours-Regular", size: 50))
                Text("My name is Aknur")
                    .foregroundStyle(.indigo)
                   
                Image("me")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("19 лет, enjoying my life, туда-сюда миллионер, стартапер")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("myColor"))
                
                Spacer()
                NavigationLink(destination: MoreInfoView()){
                    Text("More info")
                        .foregroundStyle(.indigo)
                }
                    
            }
            .padding()
        }
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView()
}
