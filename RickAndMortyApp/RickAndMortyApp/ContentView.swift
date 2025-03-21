//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Oswaldo Rincón on 10/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar personaje...", text: $viewModel.searchText, onCommit: {
                    viewModel.searchCharacters()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                List {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            HStack {
                                AsyncImage(url: URL(string: character.image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(character.name)
                                        .font(.headline)
                                    Text(character.species)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Personajes")
                .onAppear {
                    viewModel.loadCharacters()
                }
            }
        }
    }
}
