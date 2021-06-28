//
//  PokedexPresenter.swift
//  pokemon-db
//
//  Created by Admin on 27/06/21.
//

import Foundation

protocol PokedexDelegate: NSObjectProtocol {
    func listDidLoad(list: PokemonList)
    func didReceiveError(error: String)
}

class PokedexPresenter {
    
    private let pokemonService: PokemonService
    weak private var pokedexDelegate: PokedexDelegate?
    
    init(service: PokemonService) {
        self.pokemonService = service
    }
    
    func setViewDelegate(viewDelegate: PokedexDelegate?) {
        self.pokedexDelegate = viewDelegate
    }
    
    func loadList() {
        pokemonService.getList(onSuccess: { results in
            self.pokedexDelegate?.listDidLoad(list: results)
        }, onError: { error in
            self.pokedexDelegate?.didReceiveError(error: error)
        })
    }
    
}
