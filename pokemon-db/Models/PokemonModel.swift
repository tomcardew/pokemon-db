//
//  Pokemon.swift
//  pokemon-db
//
//  Created by Admin on 27/06/21.
//

import Foundation
import UIKit

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
    
    func getData(completion: @escaping(_ data: PokemonData?, _ error: String?) -> Void) {
        let service = PokemonService.shared
        service.getPokemonData(url: self.url, onSuccess: { pokemon in
            completion(pokemon, nil)
        }, onError: { error in
            completion(nil, error)
        })
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
    let types: [PokemonTypes]
    let species: PokemonSpecies
    let abilities: [PokemonAbility]
    let stats: [PokemonStat]?
    
    /**
     Returns the Pokémon ID in format 00X
     - Returns: The ID String
     */
    func getId() -> String {
        let idCharacter = "\(self.id)"
        let id = String(String(idCharacter.reversed()).padding(toLength: 3, withPad: "0", startingAt: 0).reversed())
        return id
    }
    
    func getImage() -> String {
        let idCharacter = "\(self.id)"
        let id = String(String(idCharacter.reversed()).padding(toLength: 3, withPad: "0", startingAt: 0).reversed())
        let url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/imagesHQ/\(id).png"
        return url
    }
    
    /**
     Returns the URL string to get the animated gif of the present Pokemon
     - Returns: The URL String of the resource
     */
    func getAnimatedGif() -> String {
        let name = self.name
        let url = "https://www.pkparaiso.com/imagenes/xy/sprites/animados/\(name).gif"
        return url
    }
    
    func getWeightKilograms() -> Float {
        return Float(self.weight / 10)
    }
    
    func getHeightMeters() -> Float {
        return Float(self.height / 10)
    }
    
    func getMainTypeColor() -> UIColor {
        let mainType = self.types[0].type.name
        switch mainType {
        case .grass:
            return #colorLiteral(red: 0.48, green: 0.78, blue: 0.30, alpha: 1.00)
        case .normal:
            return #colorLiteral(red: 0.66, green: 0.65, blue: 0.48, alpha: 1.00)
        case .fire:
            return #colorLiteral(red: 0.93, green: 0.51, blue: 0.19, alpha: 1.00)
        case .water:
            return #colorLiteral(red: 0.39, green: 0.56, blue: 0.94, alpha: 1.00)
        case .electric:
            return #colorLiteral(red: 0.97, green: 0.82, blue: 0.17, alpha: 1.00)
        case .ice:
            return #colorLiteral(red: 0.59, green: 0.85, blue: 0.84, alpha: 1.00)
        case .fighting:
            return #colorLiteral(red: 0.76, green: 0.18, blue: 0.16, alpha: 1.00)
        case .poison:
            return #colorLiteral(red: 0.64, green: 0.24, blue: 0.63, alpha: 1.00)
        case .ground:
            return #colorLiteral(red: 0.89, green: 0.75, blue: 0.40, alpha: 1.00)
        case .flying:
            return #colorLiteral(red: 0.66, green: 0.56, blue: 0.95, alpha: 1.00)
        case .psychic:
            return #colorLiteral(red: 0.98, green: 0.33, blue: 0.53, alpha: 1.00)
        case .bug:
            return #colorLiteral(red: 0.65, green: 0.73, blue: 0.10, alpha: 1.00)
        case .rock:
            return #colorLiteral(red: 0.71, green: 0.63, blue: 0.21, alpha: 1.00)
        case .ghost:
            return #colorLiteral(red: 0.45, green: 0.34, blue: 0.59, alpha: 1.00)
        case .dragon:
            return #colorLiteral(red: 0.44, green: 0.21, blue: 0.99, alpha: 1.00)
        case .dark:
            return #colorLiteral(red: 0.44, green: 0.34, blue: 0.27, alpha: 1.00)
        case .steel:
            return #colorLiteral(red: 0.72, green: 0.72, blue: 0.81, alpha: 1.00)
        case .fairy:
            return #colorLiteral(red: 0.84, green: 0.52, blue: 0.68, alpha: 1.00)
        }
    }
    
}

struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: DefaultItem
}

struct PokemonAbility: Codable {
    let ability: DefaultItem
    let isHidden: Bool
    let slot: Int
}

struct PokemonSprites: Codable {
    let backDefault: String?
    let frontDefault: String?
}

struct PokemonTypes: Codable {
    let slot: Int?
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: PokemonTypeEnum
    let url: String
}

struct PokemonSpecies: Codable {
    let name: String
    let url: String
}

struct PokemonSpecie: Codable {
    let baseHappiness: Int
    let captureRate: Int
    let evolutionChain: PokemonEvolution
    let evolvesFromSpecies: PokemonSpecies?
    let flavorTextEntries: [PokemonFlavors]
    let generation: DefaultItem
    let order: Int
    let varieties: [PokemonVariety]?
}

struct PokemonFlavors: Codable {
    let flavorText: String
    let language: PokemonLanguage
    let version: PokemonVersion
}

struct PokemonLanguage: Codable {
    let name: String
    let url: String
}

struct PokemonVersion: Codable {
    let name: String
    let url: String
}

struct PokemonEvolution: Codable {
    let url: String
}

struct PokemonVariety: Codable {
    let isDefault: Bool
    let pokemon: DefaultItem
}

struct DefaultItem: Codable {
    let name: String
    let url: String
}

enum PokemonTypeEnum: String, Codable {
    case grass
    case fire
    case water
    case poison
    case ground
    case normal
    case bug
    case electric
    case flying
    case ice
    case fighting
    case psychic
    case rock
    case ghost
    case dragon
    case dark
    case fairy
    case steel
    
    func getTypeIcon() -> UIImage? {
        let name = "\(self.rawValue.capitalized)Type"
        return UIImage(named: name)
    }
    
    func getMainTypeColor() -> UIColor {
        switch self {
        case .grass:
            return #colorLiteral(red: 0.48, green: 0.78, blue: 0.30, alpha: 1.00)
        case .normal:
            return #colorLiteral(red: 0.66, green: 0.65, blue: 0.48, alpha: 1.00)
        case .fire:
            return #colorLiteral(red: 0.93, green: 0.51, blue: 0.19, alpha: 1.00)
        case .water:
            return #colorLiteral(red: 0.39, green: 0.56, blue: 0.94, alpha: 1.00)
        case .electric:
            return #colorLiteral(red: 0.97, green: 0.82, blue: 0.17, alpha: 1.00)
        case .ice:
            return #colorLiteral(red: 0.59, green: 0.85, blue: 0.84, alpha: 1.00)
        case .fighting:
            return #colorLiteral(red: 0.76, green: 0.18, blue: 0.16, alpha: 1.00)
        case .poison:
            return #colorLiteral(red: 0.64, green: 0.24, blue: 0.63, alpha: 1.00)
        case .ground:
            return #colorLiteral(red: 0.89, green: 0.75, blue: 0.40, alpha: 1.00)
        case .flying:
            return #colorLiteral(red: 0.66, green: 0.56, blue: 0.95, alpha: 1.00)
        case .psychic:
            return #colorLiteral(red: 0.98, green: 0.33, blue: 0.53, alpha: 1.00)
        case .bug:
            return #colorLiteral(red: 0.65, green: 0.73, blue: 0.10, alpha: 1.00)
        case .rock:
            return #colorLiteral(red: 0.71, green: 0.63, blue: 0.21, alpha: 1.00)
        case .ghost:
            return #colorLiteral(red: 0.45, green: 0.34, blue: 0.59, alpha: 1.00)
        case .dragon:
            return #colorLiteral(red: 0.44, green: 0.21, blue: 0.99, alpha: 1.00)
        case .dark:
            return #colorLiteral(red: 0.44, green: 0.34, blue: 0.27, alpha: 1.00)
        case .steel:
            return #colorLiteral(red: 0.72, green: 0.72, blue: 0.81, alpha: 1.00)
        case .fairy:
            return #colorLiteral(red: 0.84, green: 0.52, blue: 0.68, alpha: 1.00)
        }
    }
}

struct PokemonEvolutionChain: Codable {
    let id: Int
    let babyTriggerItem: String?
    let chain: PokemonChain
}

struct PokemonChain: Codable {
    let isBaby: Bool
    let species: DefaultItem
    let evolutionDetails: [PokemonEvolutionDetails]
    let evolvesTo: [PokemonChain]
}

struct PokemonEvolutionDetails: Codable {
    let gender: Int?
    let minLevel: Int?
    let minHappiness: Int?
    let trigger: DefaultItem
}

struct PokemonAbilityDetails: Codable {
//    let effectChanges: [String]?
    let effectEntries: [EffectEntry]
    let flavorTextEntries: [PokemonFlavorExtended]
    let generation: DefaultItem
    let id: Int
    let isMainSeries: Bool
    let name: String
    let pokemon: [PokemonAbilityItem]
    
    func getEffectEntryByLanguage(lang: Language) -> EffectEntry? {
        for effect in self.effectEntries {
            if effect.language.name == lang.rawValue {
                return effect
            }
        }
        return nil
    }
    
    func getEffectFlavorByLanguage(lang: Language) -> PokemonFlavorExtended? {
        for flavor in self.flavorTextEntries {
            if flavor.language.name == lang.rawValue {
                return flavor
            }
        }
        return nil
    }
}

struct EffectEntry: Codable {
    let effect: String
    let language: DefaultItem
    let shortEffect: String
}

struct PokemonAbilityItem: Codable {
    let isHidden: Bool
    let pokemon: DefaultItem
    let slot: Int
}

struct PokemonFlavorExtended: Codable {
    let flavorText: String
    let language: DefaultItem
    let versionGroup: DefaultItem
}

enum Language: String {
    case en
    case de
    case es
}
