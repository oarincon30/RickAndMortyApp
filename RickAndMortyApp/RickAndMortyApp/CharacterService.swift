//
//  CharacterService.swift
//  RickAndMortyApp
//
//  Created by Oswaldo Rincón on 10/03/25.
//

import Foundation

class CharacterService {
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let urlString = nextPageURL, let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                DispatchQueue.main.async {
                    self.nextPageURL = decodedResponse.info.next // Guardamos la URL de la siguiente página
                    completion(.success(decodedResponse.results))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func searchCharacters(query: String, completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(query)") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
