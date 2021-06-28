//
//  Constants.swift
//  pokemon-db
//
//  Created by Admin on 24/06/21.
//

import Foundation

enum ApiBaseUrls: String {
    
    case News = "https://newsapi.org/v2"
    case Pokeapi = "https://pokeapi.co/api/v2"
    case PokemonImages = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/imagesHQ/"
    
}

enum ApiPaths: String {
    
    case News = "/everything"
    case Pokemon = "/pokemon"
    
}

enum ApiTokens: String {
    
    case News = "5591fe636e174c63b335f2ba3cb97ad6"
    
}
