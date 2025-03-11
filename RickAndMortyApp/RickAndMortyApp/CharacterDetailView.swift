//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Oswaldo Rincón on 10/03/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .shadow(radius: 10)
            
            Text(character.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                Text("Estado:")
                    .font(.headline)
                Text(character.status)
                    .foregroundColor(character.status == "Alive" ? .green : .red)
            }
            
            HStack {
                Text("Especie:")
                    .font(.headline)
                Text(character.species)
            }
            
            HStack {
                Text("Género:")
                    .font(.headline)
                Text(character.gender)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(character.name)
    }
}
