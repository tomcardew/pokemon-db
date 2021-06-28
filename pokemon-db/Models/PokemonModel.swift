//
//  Pokemon.swift
//  pokemon-db
//
//  Created by Admin on 27/06/21.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]?
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
    
    func getImage() -> String {
        let id = self.getId()
        let url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/imagesHQ/\(id).png"
        return url
    }
    
    func getId() -> String {
        let data = self.url.split(separator: "/")
        let idCharacter = data[data.count - 1]
        let id = String(String(idCharacter.reversed()).padding(toLength: 3, withPad: "0", startingAt: 0).reversed())
        return id
    }
    
}

struct PokemonData: Codable {
    let id: Int
    let name: String
    let isDefault: Bool
    let height: Double
    let order: Int
    let weight: Int
    let sprites: PokemonSprites
    
    func getImage() -> String {
        let idCharacter = "\(self.id)"
        let id = String(String(idCharacter.reversed()).padding(toLength: 3, withPad: "0", startingAt: 0).reversed())
        let url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/imagesHQ/\(id).png"
        return url
    }
}

struct PokemonSprites: Codable {
    let backDefault: String?
    let frontDefault: String?
}
