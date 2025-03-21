//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Oswaldo Rincón on 10/03/25.
//

import Foundation

class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private let service = CharacterService()

    func loadCharacters() {
        service.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newCharacters):
                    self?.characters.append(contentsOf: newCharacters) // Agregamos los nuevos personajes a la lista
                case .failure(let error):
                    print("Error al obtener personajes: \(error)")
                }
            }
        }
    }
    
    @Published var searchText: String = ""

    func searchCharacters() {
        service.searchCharacters(query: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let foundCharacters):
                    self?.characters = foundCharacters
                case .failure(let error):
                    print("Error en búsqueda: \(error)")
                }
            }
        }
    }
}
