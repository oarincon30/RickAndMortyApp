//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Oswaldo Rincón on 10/03/25.
//
import Foundation

struct CharacterResponse: Codable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}
