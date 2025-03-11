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
                case .success(let characters):
                    self?.characters = characters
                case .failure(let error):
                    print("Error al obtener personajes: \(error)")
                }
            }
        }
    }
}
